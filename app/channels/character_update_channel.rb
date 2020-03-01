# typed: true
# frozen_string_literal: true

# Sets up connection to character page client code.
# Updates consist of HTML content which is sent in response to back-end
# model changes.
class CharacterUpdateChannel < ApplicationCable::Channel
  # @option data [String] 'id' id of {Character} to stream updates for
  # @option data [String] 'timestamp' timestamp of when client character data
  #   was last updated
  # @return [void]
  def follow(data)
    stop_all_streams
    raise "Invalid data: #{data}" unless valid_data?(data)

    character = Character.find(data["id"])
    stream_from "characters:#{character.to_param}:armory_updates"

    # Try to trigger broadcast immediately as character may have been updated
    # in time between initial request and ActionCable connection.
    CharacterUpdateBroadcaster.call(character, data["timestamp"])
  rescue ActiveRecord::RecordNotFound
    logger.warn "CharacterUpdateChannel: No Character with found with id: #{data["id"]}"
  end

  # @return [void]
  def unfollow
    stop_all_streams
  end

  private

  def valid_data?(data)
    data["id"].present? && data["timestamp"].present?
  end
end
