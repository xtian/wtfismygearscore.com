# frozen_string_literal: true

# Wraps {CharacterUpdater} and {CharacterUpdateBroadcaster} in a background job
class CharacterUpdaterJob < ApplicationJob
  # @param character [Character] character to check for updates
  # @return [void]
  def perform(character)
    broadcast(update(character), character.updated_at)
  rescue Armory::ServerError => e
    Rails.logger.warn "#{self.class} #{e.inspect}"
  end

  private

  def broadcast(*args)
    CharacterUpdateBroadcaster.call(*args)
  end

  def update(*args)
    CharacterUpdater.call(*args)
  end
end
