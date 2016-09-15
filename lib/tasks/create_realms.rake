# frozen_string_literal: true
require 'faraday'
require 'json'

API_KEY = Rails.application.secrets.armory_api_key

LOCALES = {
  us: %w(es_MX pt_BR),
  eu: %w(es_ES fr_FR ru_RU de_DE pt_PT it_IT),
  kr: %w(ko_KR),
  tw: %w(zh_TW)
}.freeze

desc 'Create Realms from Armory realm status API'
task create_realms: :environment do
  realms = {}

  LOCALES.each do |region, locales|
    fetch_realms(region, 'en_US').each do |realm|
      name = realm.fetch('name')
      slug = realm.fetch('slug')

      # Use the en_US realm name as the default
      realms[name] = name.casecmp(slug).zero? ? [] : [slug]

      # Check each locale for a different returned name
      locales.each do |locale|
        puts "Checking for translation: #{region} #{name} #{locale}"

        # Realms must be checked individually as the status API does not
        # include a unique ID or in a consistent order
        locale_realm = fetch_realms(region, locale, slug).first
        locale_name = locale_realm.fetch('name')
        locale_slug = locale_realm.fetch('slug')

        next if name.casecmp(locale_name).zero? || locale_name.in?(realms[name])

        puts "Translation found: #{locale_name}"
        realms[name] << locale_name
        realms[name] << locale_slug if locale_name.casecmp(locale_slug).nonzero?
      end
    end
  end

  # Some Korean connected realms aren't returned independently so they
  # have to be translated based on their slugs
  fetch_realms('kr', 'en_US').each do |realm|
    connected = realm.fetch('connected_realms')
    locale_connected = fetch_realms('kr', 'ko_KR', realm.fetch('slug')).first.fetch('connected_realms')

    connected.zip(locale_connected)
      .drop(1) # The first item is the requested realm
      .map { |pair| pair.map(&:titleize) }
      .each do |name, translation|
        name = "Gul'dan" if name == 'Guldan'
        realms[name] << translation unless translation.in?(realms[name])
      end
  end

  # Create Realm records
  realms.each do |name, translations|
    Realm.find_or_initialize_by(name: name).update!(translations: translations)
  end

  # Save a seed file
  yaml = realms.map { |name, translations| { 'name' => name, 'translations' => translations } }.to_yaml
  File.write(Rails.root.join('db/seeds/realms.yml'), yaml)
end

def fetch_realms(region, locale, slug = nil)
  url = "https://#{region}.api.battle.net/wow/realm/status?apikey=#{API_KEY}&locale=#{locale}"
  url += "&realms=#{slug}" if slug

  JSON.parse(Faraday.get(url).body).fetch('realms')
rescue KeyError
  # Retry if API returns an error
  fetch_realms(region, locale, slug)
end
