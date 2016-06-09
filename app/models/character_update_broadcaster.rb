# frozen_string_literal: true
class CharacterUpdateBroadcaster
  def initialize(character, updated_at)
    @caller_updated_at = updated_at
    @character = character
  end

  def self.call(character, updated_at)
    new(character, updated_at).call
  end

  def call
    return unless character.updated_at > caller_updated_at
    ActionCable.server.broadcast channel_name, html: partial, id: character.to_param
  end

  private

  attr_reader :caller_updated_at, :character

  def channel_name
    "characters:#{character.to_param}:armory_updates"
  end

  def partial
    CharactersController.render(
      partial: 'characters/character',
      locals: { character: CharacterPresenter.new(character) }
    )
  end
end
