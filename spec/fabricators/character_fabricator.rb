Fabricator(:character) do
  character_class { CLASSES.sample }
  level { Random.rand(100) + 1 }
  realm 'Shadowmoon'
  region { VALID_REGIONS_WITH_REALM.sample }
  score { Random.rand(30_000) + 1 }

  name do
    sequence(:name) { |i| "Character#{i}" }
  end
end
