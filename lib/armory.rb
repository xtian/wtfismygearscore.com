require 'armory/character'
require 'faraday'
require 'json'

class Armory
  def initialize(api_key)
    @api_key = api_key
  end

  def fetch_character(region, realm, name)
    url = "https://#{region}.api.battle.net/wow/character/#{realm}/#{name}?apiKey=#{api_key}&fields=guild"
    response = make_request(url)
    body = JSON.parse(response.body)

    raise StandardError, "#{url}\n#{body['code']} #{body['detail']}" if response.status != 200

    Character.new(region, body)
  end

  private

  attr_reader :api_key

  def make_request(url)
    Faraday.get do |req|
      req.headers['Accept'] = 'application/json'
      req.url url
    end
  end
end
