# frozen_string_literal: true
require 'faraday'
require 'typhoeus/adapters/faraday'

# Encapsulates logic for making requests to Akismet spam detection service
class Akismet
  # @param is_test [Boolean] whether request is a test
  # @param key [String] API key
  # @param url [String] Site URL
  def initialize(is_test:, key:, url:)
    @is_test = is_test
    @key = key
    @url = url

    raise ArgumentError, 'Akismet key and url required' unless key && url
  end

  # @param comment [Comment] posted comment
  # @param referrer [String] referrer for comment POST request
  # @param user_agent [String] User agent string for user's browser
  # @return [Boolean] whether passed info is detected as spam
  # @raise [StandardError] if request is considered invalid
  # @see https://akismet.com/development/api/#comment-check Akismet Documentation
  def spam?(comment, referrer:, user_agent:)
    params = params_for(comment, referrer, user_agent)
    response = make_request(params)

    raise response.headers.fetch('X-akismet-debug-help') if response.body.eql?('invalid')
    response.body.eql?('true')
  end

  private

  attr_reader :is_test, :key, :url

  def faraday
    @_faraday ||= Faraday.new(url: "https://#{key}.rest.akismet.com")
  end

  def make_request(params)
    faraday.get do |req|
      req.url '/1.1/comment-check'
      req.params = params
    end
  end

  def params_for(comment, referrer, user_agent)
    {
      blog: url,
      comment_author: comment.poster_name,
      comment_content: comment.body,
      comment_date_gmt: comment.created_at.iso8601,
      is_test: is_test,
      referrer: referrer,
      user_agent: user_agent,
      user_ip: comment.poster_ip_address
    }
  end
end
