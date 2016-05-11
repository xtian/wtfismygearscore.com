class UpdateCharacterFromArmoryJob < ApplicationJob
  def perform(character)
    return if recently_updated?(character)

    armory_response = ARMORY.fetch_character(
      character.region,
      character.realm,
      character.name
    )

    score = GearscoreCalculator.calculate(armory_response.items)

    character.update_from_armory(armory_response, score)
  end

  private

  def recently_updated?(character)
    # Don't update cache if it was updated less than fifteen minutes ago
    !character.new_record? && character.updated_at + 15.minutes > Time.current
  end
end
