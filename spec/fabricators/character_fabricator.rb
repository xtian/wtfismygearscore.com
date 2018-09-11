# frozen_string_literal: true

Fabricator(:character) do
  api_updated_at { Time.current }
  avg_ilvl { rand(1..700) }
  class_name { CLASSES.sample }
  faction { FACTIONS.sample }
  level { rand(1..120) }
  max_ilvl { rand(1..700) }
  min_ilvl { rand(1..700) }
  region { VALID_REGIONS_WITH_REALM.sample }
  score { rand(1..30_000) }

  name do
    sequence(:name) { |i| "Character#{i}" }
  end

  realm do
    sequence(:realm) { |i| "Realm#{i}" }
  end

  after_save { |character| Realm.find_or_create_by!(name: character.realm) }
end
