# frozen_string_literal: true
require 'json'

class Armory
  # Simple wrapper around Armory API responses
  class Response
    # @param response_object [Faraday::Response] return from Faraday request
    def initialize(response_object)
      @response = response_object
    end

    # @return [Hash] parsed response body
    def body
      @_body ||= response.body.present? ? JSON.parse(response.body) : {}
    end

    # @return [String] Armory debug message
    def error_message
      [body.fetch('code', status), body.fetch('detail', nil)].compact.join(' ')
    end

    # @return [Fixnum] HTTP status code
    def status
      return 404 if response.status == 200 && body == {}
      response.status
    end

    private

    attr_reader :response
  end
end
