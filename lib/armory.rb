# frozen_string_literal: true

require "addressable"
require "armory/character"
require "faraday"

# Encapsulates logic for making requests to the Blizzard API
class Armory
  # @param client_id [String] Blizzard OAuth client ID
  # @param client_secret [String] Blizzard OAuth client secret
  # @param timeout [Integer] Request timeout in seconds
  def initialize(client_id:, client_secret:, timeout:)
    @client_id = client_id
    @client_secret = client_secret
    @timeout = timeout
  end

  # @param region [String]
  # @param realm [String]
  # @param name [String]
  # @return [Armory::Character]
  # @raise [Armory::ServerError] if API returns 401, 500-504, or invalid JSON
  # @raise [Armory::NotFoundError] if API returns 404
  # @raise [Armory::NotUpdatedError] if API returns 403
  # @raise [StandardError] for all other API errors
  # @see https://develop.battle.net/documentation/world-of-warcraft/profile-apis Blizzard API docs
  def fetch_character(region:, realm:, name:)
    profile_body = fetch_character_data(region, realm, name)
    equipment_body = fetch_character_data(region, realm, name, "equipment")

    Character.new(
      region: region,
      profile_body: profile_body,
      equipment_body: equipment_body,
    )
  end

  private

  attr_reader :access_token_expiry, :client_id, :client_secret, :timeout

  class NotFoundError < StandardError; end
  class NotUpdatedError < StandardError; end
  class ServerError < StandardError; end

  def access_token
    @_access_token = nil if access_token_expiry&.past?

    @_access_token ||= begin
      response_body = fetch_access_token

      @access_token_expiry = response_body.fetch("expires_in").seconds.from_now - 1.hour.seconds

      response_body.fetch("access_token")
    end
  end

  def fetch_access_token
    url = "https://us.battle.net/oauth/token"
    query = "?grant_type=client_credentials&client_id=#{client_id}&client_secret=#{client_secret}"

    response = Faraday.post(url + query) do |req|
      req.options.open_timeout = timeout
      req.options.timeout = timeout
    end

    raise "Request failed (#{response.status}): #{url}" if response.status != 200

    JSON.parse(response.body)
  end

  # rubocop:disable Metrics/AbcSize
  def fetch_character_data(region, realm, name, endpoint = nil)
    url = build_character_url(region, realm, name, endpoint)

    response = Faraday.get(url) do |req|
      req.options.open_timeout = timeout
      req.options.timeout = timeout
    end

    case response.status
    when 200 then JSON.parse(response.body)
    when 403 then raise NotUpdatedError, url
    when 404 then raise NotFoundError, url
    when 401, 500..504 then raise ServerError, url
    else raise "Request failed (#{response.status}): #{url}"
    end
  rescue Faraday::ConnectionFailed, Faraday::TimeoutError, JSON::ParserError
    raise ServerError, url
  end
  # rubocop:enable Metrics/AbcSize

  def build_character_url(region, realm, name, endpoint)
    realm = realm.gsub(" ", "-").gsub(/[()']/, "").downcase
    url = "https://#{region}.api.blizzard.com/profile/wow/character/#{realm}/#{name.downcase}"
    url += "/#{endpoint}" if endpoint

    url = Addressable::URI.encode(url).gsub("%5C", "'")
    query = "?access_token=#{access_token}&namespace=profile-#{region}&locale=en_US"

    url + query
  end
end
