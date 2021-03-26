# frozen_string_literal: true

Character.create!(
  avg_ilvl: 681,
  class_name: "hunter",
  faction: "alliance",
  guild_name: "The Gentlemens Club",
  level: 100,
  max_ilvl: 795,
  min_ilvl: 655,
  name: "Dargonaut",
  realm: "Shadowmoon",
  region: "us",
  score: 19_891,
)

Character.create!(
  avg_ilvl: 457,
  class_name: "shaman",
  faction: "neutral",
  guild_name: nil,
  level: 100,
  max_ilvl: 605,
  min_ilvl: 10,
  name: "Doubleagent",
  realm: "Mannoroth",
  region: "us",
  score: 10_331,
)

realms = YAML.load_file(Rails.root.join("db/seeds/realms.yml"))
Realm.create!(realms)
