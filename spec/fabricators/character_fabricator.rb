Fabricator(:character) do
  avg_ilvl { Random.rand(700) + 1 }
  class_name { CLASSES.sample }
  level { Random.rand(100) + 1 }
  max_ilvl { Random.rand(700) + 1 }
  min_ilvl { Random.rand(700) + 1 }
  realm 'Shadowmoon'
  region { VALID_REGIONS_WITH_REALM.sample }
  score { Random.rand(30_000) + 1 }

  name do
    sequence(:name) { |i| "Character#{i}" }
  end
end
