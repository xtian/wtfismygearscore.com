# frozen_string_literal: true
require 'addressable'
require 'armory/character'
require 'faraday'
require 'json'
require 'typhoeus/adapters/faraday'

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
  # @raise [Armory::NotFoundError] if API returns 404
  # @raise [StandardError] for all other API errors
  # @see https://dev.battle.net/io-docs Armory API docs
  def fetch_character(region:, realm:, name:)
    url = build_url(region, realm, name)
    response = make_request(url)
    body = JSON.parse(response.body)

    case response.status
    when 200 then Character.new(region, body)
    when 404 then raise NotFoundError, url
    else raise StandardError, "#{url}\n#{body['code']} #{body['detail']}"
    end
  end

  private

  attr_reader :api_key

  class NotFoundError < StandardError; end

  def build_url(region, realm, name)
    url = "https://#{region}.api.battle.net/wow/character/#{realm}/#{name}"
    query = "?apikey=#{api_key}&locale=en_US&fields=guild,items"
    Addressable::URI.encode(url + query)
  end

  def faraday
    @_faraday ||= Faraday.new do |faraday|
      faraday.adapter :typhoeus
    end
  end

  def make_request(url)
    faraday.get do |req|
      req.headers['Accept'] = 'application/json'
      req.url url
    end
  end
end
