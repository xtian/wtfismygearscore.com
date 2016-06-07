# frozen_string_literal: true
require 'armory/character'
require 'faraday'
require 'json'
require 'typhoeus/adapters/faraday'

class Armory
  def initialize(api_key)
    @api_key = api_key
  end

  def fetch_character(region:, realm:, name:)
    url = build_url(region, realm, name)
    response = make_request(url)
    body = JSON.parse(response.body)

    raise StandardError, "#{url}\n#{body['code']} #{body['detail']}" if response.status != 200

    Character.new(region, body)
  end

  private

  attr_reader :api_key

  def build_url(region, realm, name)
    "https://#{region}.api.battle.net/wow/character/#{realm}/#{name}?apikey=#{api_key}&fields=guild,items"
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
