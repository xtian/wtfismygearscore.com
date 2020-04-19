# frozen_string_literal: true

# Encapsulates logic for broadcasting HTML character updates over ActionCable
module CharacterUpdateBroadcaster
  # Broadcasts update to the relevant {CharacterUpdateChannel} if given
  # {Character} was updated more recently than given timestamp
  # @param character [Character]
  # @param updated_at [String, DateTime]
  # @return [void]
  def self.call(character, updated_at)
    return unless character.updated_at > updated_at

    channel_name = "characters:#{character.to_param}:armory_updates"
    partial = CharactersController.render(
      partial: "characters/character",
      locals: { character: CharacterPresenter.new(character) },
    )

    ActionCable.server.broadcast channel_name, html: partial, id: character.to_param
  end
end
