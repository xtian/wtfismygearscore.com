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
      # Use the en_US realm name as the default
      name = realm.fetch('name')
      realms[name] ||= []

      # Check each locale for a different returned name
      locales.each do |locale|
        puts "Checking for translation: #{region} #{name} #{locale}"

        # Realms must be checked individually as the status API does not
        # include a unique ID or in a consistent order
        locale_name = fetch_realms(region, locale, realm.fetch('slug')).first.fetch('name')

        if name.casecmp(locale_name).nonzero? && !locale_name.in?(realms[name])
          puts "Translation found: #{locale_name}"
          realms[name] << locale_name
        end
      end
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
