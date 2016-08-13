# frozen_string_literal: true
module CharacterHelpers
  def fabricate_character(params = {})
    Fabricate(:character, params).tap do |character|
      Realm.find_or_create_by!(name: character.realm)
    end
  end
end

RSpec.configure do |config|
  config.include CharacterHelpers
end
