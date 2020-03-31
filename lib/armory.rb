# typed: false
# frozen_string_literal: true

require "addressable"
require "armory/character"
require "armory/response"
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
  # @raise [Armory::ServerError] if API returns 500, 503, 504, or invalid JSON
  # @raise [Armory::NotFoundError] if API returns 400 or 404
  # @raise [StandardError] for all other API errors
  # @see https://develop.battle.net/documentation/api-reference Blizzard API docs
  def fetch_character(region:, realm:, name:)
    url = build_url(region, realm, name)
    response = Response.new(send_request(url))

    case response.status
    when 200 then Character.new(region, response.body)
    when 400, 403, 404 then raise NotFoundError, url
    when 401, 500..504 then raise ServerError, url
    else raise "#{url}\n#{response.error_message}"
    end
  rescue Faraday::ConnectionFailed, Faraday::TimeoutError, JSON::ParserError
    raise ServerError, url
  end

  private

  attr_reader :access_token_expiry, :client_id, :client_secret, :timeout

  class NotFoundError < StandardError; end
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

    response = Response.new(send_request(url + query))
    raise response.error_message if response.status != 200

    response.body
  end

  def build_url(region, realm, name)
    url = "https://#{region}.api.blizzard.com/wow/character/#{realm}/#{name}"
    query = "?access_token=#{access_token}&locale=en_US&fields=guild,items"
    Addressable::URI.encode(url + query)
  end

  def send_request(url)
    Faraday.get do |req|
      req.url url
      req.options.open_timeout = timeout
      req.options.timeout = timeout
    end
  end
end
