# typed: true
# frozen_string_literal: true

# Updates a given {Character} with latest data from the Armory
module CharacterUpdater
  class << self
    # Updates {Character} with latest Armory data unless it has been updated in
    # the recent past. Will destroy {Character} if Armory returns a 404.
    # @param character [Character]
    # @return [Character] updated character
    def call(character)
      return character if recently_updated?(character)

      character_params = params(character)
      armory_response = ARMORY.fetch_character(**character_params)
      score = GearscoreCalculator.calculate(armory_response.items)

      unless character.should_update?(armory_response.api_id)
        character.destroy!
        character = Character.new(**character_params)
      end

      character.update_from_armory(armory_response, score)
      character
    rescue Armory::NotFoundError
      raise if character.new_record?

      Rails.logger.warn "#{params(character)} did not resolve to a valid Armory profile. Deleting cached character."
      character.destroy!
    end

    private

    def params(character)
      {
        region: character.region,
        realm: character.realm,
        name: character.name,
      }
    end

    def recently_updated?(character)
      # Don't update cache if it was updated less than fifteen minutes ago
      !character.new_record? && character.updated_at > 15.minutes.ago
    end
  end
end
