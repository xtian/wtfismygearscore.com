# frozen_string_literal: true
class CharacterUpdateChannel < ApplicationCable::Channel
  def follow(data)
    raise "Invalid data: #{data}" unless valid_data?(data)

    character = Character.find(data['id'])
    stream_from "characters:#{character.to_param}:armory_updates"

    CharacterUpdateBroadcaster.call(character, data['timestamp'])

  rescue ActiveRecord::RecordNotFound
    logger.warn "CharacterUpdateChannel: No Character with found with id: #{data['id']}"
  end

  private

  def valid_data?(data)
    data['id'] && data['timestamp']
  end
end
