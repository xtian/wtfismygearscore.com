# typed: true
# frozen_string_literal: true

require "json"

class Armory
  # Simple wrapper around Blizzard API responses
  class Response
    # @param response_object [Faraday::Response] return from Faraday request
    def initialize(response_object)
      @response = response_object
    end

    # @raise [JSON::ParserError] for non-JSON response bodies
    # @return [Hash] parsed response body
    def body
      @_body ||= response.body.present? ? JSON.parse(response.body) : {}
    end

    # @return [String] Armory debug message
    def error_message
      [status, body.fetch("detail", nil)].compact.join(" ")
    end

    # @return [Integer] HTTP status code
    def status
      return 500 if response.status.equal?(200) && body.empty?

      response.status
    end

    private

    attr_reader :response
  end
end
