class CharacterUpdaterJob < ApplicationJob
  def perform(character)
    CharacterUpdater.call(character)
  end
end
