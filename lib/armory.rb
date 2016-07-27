# frozen_string_literal: true
require 'addressable'
require 'armory/character'
require 'armory/response'
require 'faraday'

# Encapsulates logic for making requests to Battle.net Armory API
class Armory
  # @param api_key [String] Armory API key
  def initialize(api_key)
    @api_key = api_key
  end

  # @param region [String]
  # @param realm [String]
  # @param name [String]
  # @return [Armory::Character]
  # @raise [Armory::GatewayTimeoutError] if API returns 504
  # @raise [Armory::InternalServerError] if API returns 500
  # @raise [Armory::NotFoundError] if API returns 400 or 404
  # @raise [StandardError] for all other API errors
  # @see https://dev.battle.net/io-docs Armory API docs
  def fetch_character(region:, realm:, name:)
    url = build_url(region, realm, name)
    response = Response.new(Faraday.get(url))

    case response.status
    when 200      then Character.new(region, response.body)
    when 400, 404 then raise NotFoundError, url
    when 500      then raise InternalServerError, url
    when 504      then raise GatewayTimeoutError, url
    else raise "#{url}\n#{response.error_message}"
    end
  end

  private

  attr_reader :api_key

  class GatewayTimeoutError < StandardError; end
  class InternalServerError < StandardError; end
  class NotFoundError < StandardError; end

  def build_url(region, realm, name)
    url = "https://#{region}.api.battle.net/wow/character/#{realm}/#{name}"
    query = "?apikey=#{api_key}&locale=en_US&fields=guild,items"
    Addressable::URI.encode(url + query)
  end
end
