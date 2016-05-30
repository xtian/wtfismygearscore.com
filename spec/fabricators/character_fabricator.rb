Fabricator(:character) do
  avg_ilvl { rand(700) + 1 }
  class_name { CLASSES.sample }
  guild_name 'The Gentlemens Club'
  level { rand(100) + 1 }
  max_ilvl { rand(700) + 1 }
  min_ilvl { rand(700) + 1 }
  realm 'Shadowmoon'
  region { VALID_REGIONS_WITH_REALM.sample }
  score { rand(30_000) + 1 }

  name do
    sequence(:name) { |i| "Character#{i}" }
  end
end
