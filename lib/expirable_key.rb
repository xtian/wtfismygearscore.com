# typed: true
# frozen_string_literal: true

# https://gist.github.com/Skulli/80a3f31d1b25b7b98c025b2bd182aa4a
class ExpirableKey
  def initialize(key, redis: Redis.current, expire_in: 60)
    @key = key
    @redis = redis
    @expire_in = expire_in
  end

  def exist_with_renew?
    result = redis.get(key).present?
    set

    result
  end

  private

  attr_reader :key, :redis, :expire_in

  def set
    redis.set(key, true)
    redis.expire(key, expire_in)
  end
end
