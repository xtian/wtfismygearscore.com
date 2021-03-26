# frozen_string_literal: true

if Rails.env.development?
  require "dotenv/rails-now"
  require "faraday"
  require "json"

  CLIENT_ID = ENV.fetch("BLIZZARD_CLIENT_ID")
  CLIENT_SECRET = ENV.fetch("BLIZZARD_CLIENT_SECRET")

  LOCALES = {
    us: %w[es pt],
    eu: %w[es fr ru de pt it],
    kr: %w[ko],
    tw: %w[zh],
  }.freeze

  desc "Build realms.yml seed file from Armory realm status API"
  task build_realms_seed: :environment do
    realms = {}

    token_url = "https://us.battle.net/oauth/token"
    token_url += "?grant_type=client_credentials&client_id=#{CLIENT_ID}&client_secret=#{CLIENT_SECRET}"

    response = Faraday.get(token_url)
    raise response.body if response.status != 200

    access_token = JSON.parse(response.body).fetch("access_token")

    LOCALES.each do |region, locales|
      fetch_realms(access_token, region, "en").each do |realm|
        name = realm.fetch("name")
        slug = realm.fetch("slug")

        # Use the en_US realm name as the default
        realms[name] = name.casecmp(slug).zero? ? [] : [slug]

        # Check each locale for a different returned name
        locales.each do |locale|
          puts "Checking for translation: #{region} #{name} #{locale}"

          # Realms must be checked individually as the status API does not
          # include a unique ID or return in a consistent order
          locale_realm = fetch_realms(access_token, region, locale, slug).first
          locale_name = locale_realm.fetch("name")
          locale_slug = locale_realm.fetch("slug")

          next if name.casecmp(locale_name).zero? || locale_name.in?(realms[name])

          puts "Translation found: #{locale_name}"
          realms[name] << locale_name
          realms[name] << locale_slug if locale_name.casecmp(locale_slug).nonzero?
        end
      end
    end

    # Some Korean connected realms aren't returned independently so they
    # have to be translated based on their slugs
    fetch_realms(access_token, "kr", "en").each do |realm|
      connected = realm.fetch("connected_realms")
      locale_connected = fetch_realms(access_token, "kr", "ko", realm.fetch("slug")).first.fetch("connected_realms")

      connected.zip(locale_connected)
        .drop(1) # The first item is the requested realm
        .map { |pair| pair.map(&:titleize) }
        .each do |name, translation|
        name = "Gul'dan" if name == "Guldan"
        name = "Zul'jin" if name == "Zuljin"

        realms[name] << translation unless translation.in?(realms[name])
      end
    end

    # Save a seed file
    yaml = realms.map { |name, translations| { "name" => name, "translations" => translations } }.to_yaml
    File.write(Rails.root.join("db/seeds/realms.yml"), yaml)
  end

  def fetch_realms(access_token, region, locale, slug = nil)
    url = "https://#{region}.api.blizzard.com/wow/realm/status"
    url += "?access_token=#{access_token}&locale=#{locale}"
    url += "&realms=#{slug}" if slug

    response = Faraday.get(url)
    raise response.body if response.status != 200

    JSON.parse(response.body).fetch("realms")
  rescue KeyError
    # Retry if API returns an error
    fetch_realms(access_token, region, locale, slug)
  end
end
