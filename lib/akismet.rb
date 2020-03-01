# typed: true
# frozen_string_literal: true

require "faraday"

# Encapsulates logic for making requests to Akismet spam detection service
class Akismet
  # @param is_test [Boolean] whether request is a test
  # @param key [String] API key
  # @param url [String] Site URL
  def initialize(is_test:, key:, url:)
    @is_test = is_test
    @key = key
    @url = url

    raise ArgumentError, "Akismet key and url required" unless key && url
  end

  # @param comment [Comment] posted comment
  # @return [Boolean] whether passed info is detected as spam
  # @raise [StandardError] if request is considered invalid
  # @see https://akismet.com/development/api/#comment-check Akismet Documentation
  def spam?(comment)
    make_request("comment-check", comment).body.eql?("true")
  end

  # @param comment [Comment] posted comment
  # @return [void]
  # @raise [StandardError] if request is considered invalid
  # @see https://akismet.com/development/api/#submit-spam Akismet Documentation
  def spam!(comment)
    make_request("submit-spam", comment)
  end

  private

  attr_reader :is_test, :key, :url

  def faraday
    @_faraday ||= Faraday.new(url: "https://#{key}.rest.akismet.com")
  end

  def make_request(url, comment)
    response = faraday.post("/1.1/#{url}", params_for(comment))

    raise response["X-akismet-debug-help"] if response["X-akismet-debug-help"]

    response
  end

  def params_for(comment)
    {
      blog: url,
      comment_author: comment.poster_name,
      comment_content: comment.body,
      comment_date_gmt: comment.created_at.iso8601,
      is_test: is_test,
      referrer: comment.referrer,
      user_agent: comment.user_agent,
      user_ip: comment.poster_ip_address,
    }
  end
end
