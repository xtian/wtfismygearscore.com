Fabricator(:character) do
  avg_ilvl { rand(700) + 1 }
  class_name { CLASSES.sample }
  level { rand(100) + 1 }
  max_ilvl { rand(700) + 1 }
  min_ilvl { rand(700) + 1 }
  realm 'Shadowmoon'
  region { VALID_REGIONS_WITH_REALM.sample }
  score { rand(30_000) + 1 }

  name do
    sequence(:name) { |i| "Character#{i}" }
  end

  guild_name do
    sequence(:guild_name) { |i| "Guild#{i}" }
  end
end
