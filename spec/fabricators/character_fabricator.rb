# frozen_string_literal: true
Fabricator(:character) do
  avg_ilvl { rand(700) + 1 }
  class_name { CLASSES.sample }
  faction { FACTIONS.sample }
  level { rand(110) + 1 }
  max_ilvl { rand(700) + 1 }
  min_ilvl { rand(700) + 1 }
  region { VALID_REGIONS_WITH_REALM.sample }
  score { rand(30_000) + 1 }

  name do
    sequence(:name) { |i| "Character#{i}" }
  end

  after_build do |character|
    character.realm ||= Fabricate.sequence(:realm) { |i| "Realm#{i}" }
  end

  after_save { |character| Realm.find_or_create_by!(name: character.realm) }
end
