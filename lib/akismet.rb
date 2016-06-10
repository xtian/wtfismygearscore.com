# frozen_string_literal: true
require 'faraday'
require 'typhoeus/adapters/faraday'

class Akismet
  def initialize(is_test:, key:, url:)
    @is_test = is_test
    @key = key
    @url = url

    raise ArgumentError, 'Akismet key and url required' unless key && url
  end

  def spam?(comment, referrer:, user_agent:)
    params = params_for(comment, user_agent, referrer)
    response = make_request(params)

    raise response.headers['X-akismet-debug-help'] if response.body.eql?('invalid')
    response.body.eql?('true')
  end

  private

  attr_reader :is_test, :key, :url

  def faraday
    @_faraday ||= Faraday.new(url: "https://#{key}.rest.akismet.com") do |faraday|
      faraday.adapter :typhoeus
    end
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
      comment_date_gmt: comment.created_at.utc.iso8601,
      is_test: is_test,
      referrer: referrer,
      user_agent: user_agent,
      user_ip: comment.poster_ip_address.to_s
    }
  end
end