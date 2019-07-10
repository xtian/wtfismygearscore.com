# typed: true
# frozen_string_literal: true

# Updates a given {Character} with latest data from the Armory
class CharacterUpdater
  # @param character [Character]
  def initialize(character)
    @character = character
  end

  # Convenience method to avoid object initialization
  # @param character [Character]
  # @return [Character]
  def self.call(character)
    new(character).call
  end

  # Updates {Character} with latest Armory data unless it has been updated in
  # the recent past. Will destroy {Character} if Armory returns a 404.
  # @return [Character] updated character
  def call
    return character if recently_updated?

    character.update_from_armory(armory_response, score)
    character
  rescue Armory::NotFoundError
    handle_not_found
  end

  private

  attr_reader :character

  def armory_response
    @_armory_response ||= ARMORY.fetch_character(params)
  end

  def handle_not_found
    raise if character.new_record?

    Rails.logger.warn "#{params} did not resolve to a valid Armory profile. Deleting cached character."
    character.destroy!
  end

  def params
    {
      region: character.region,
      realm: character.realm,
      name: character.name
    }
  end

  def recently_updated?
    # Don't update cache if it was updated less than fifteen minutes ago
    !character.new_record? && character.updated_at > 15.minutes.ago
  end

  def score
    GearscoreCalculator.calculate(armory_response.items)
  end
end
