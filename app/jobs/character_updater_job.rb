# frozen_string_literal: true

# Wraps {CharacterUpdater} and {CharacterUpdateBroadcaster} in a background job
class CharacterUpdaterJob < ApplicationJob
  rescue_from ActiveJob::DeserializationError, with: :log_error
  rescue_from ActiveRecord::RecordNotUnique, with: :log_error
  rescue_from Armory::ServerError, with: :log_error

  # @param character [Character] character to check for updates
  # @return [void]
  def perform(character)
    broadcast(update(character), character.updated_at)
  end

  private

  def broadcast(*args)
    CharacterUpdateBroadcaster.call(*args)
  end

  def log_error(e)
    Rails.logger.warn "#{self.class} #{e.inspect}"
  end

  def update(*args)
    CharacterUpdater.call(*args)
  end
end
