# frozen_string_literal: true
class CharacterUpdaterJob < ApplicationJob
  def perform(character)
    broadcast(update(character), character.updated_at)
  end

  private

  def broadcast(*args)
    CharacterUpdateBroadcaster.call(*args)
  end

  def update(*args)
    CharacterUpdater.call(*args)
  end
end
