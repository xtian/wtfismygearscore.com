# frozen_string_literal: true
class CharacterUpdater
  def initialize(character)
    @character = character
  end

  def self.call(character)
    new(character).call
  end

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
