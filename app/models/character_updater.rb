class CharacterUpdater
  def initialize(character)
    @character = character
  end

  def self.call(character)
    new(character).call
  end

  def call
    return character if recently_updated?

    armory_response = ARMORY.fetch_character(
      character.region,
      character.realm,
      character.name
    )

    score = GearscoreCalculator.calculate(armory_response.items)
    character.update_from_armory(armory_response, score)

    character
  end

  private

  attr_reader :character

  def recently_updated?
    # Don't update cache if it was updated less than fifteen minutes ago
    !character.new_record? && character.updated_at + 15.minutes > Time.current
  end
end
