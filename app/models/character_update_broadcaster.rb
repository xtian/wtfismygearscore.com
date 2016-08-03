# frozen_string_literal: true

# Encapsulates logic for broadcasting HTML character updates over ActionCable
class CharacterUpdateBroadcaster
  # @param character [Character]
  # @param updated_at [String, DateTime]
  def initialize(character, updated_at)
    @caller_updated_at = updated_at
    @character = character
  end

  # Convenience method to avoid object initialization
  # @param character [Character]
  # @param updated_at [String, DateTime]
  # @return [void]
  def self.call(character, updated_at)
    new(character, updated_at).call
  end

  # Broadcasts update to the relevant {CharacterUpdateChannel} if given
  # {Character} was updated more recently than given timestamp
  # @return [void]
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
