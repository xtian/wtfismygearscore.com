# frozen_string_literal: true

CLASSES = [
  'warrior',
  'paladin',
  'hunter',
  'rogue',
  'priest',
  'death knight',
  'shaman',
  'mage',
  'warlock',
  'monk',
  'druid',
  'demon hunter'
].freeze

FACTIONS = %w(alliance horde neutral).freeze

VALID_REGIONS = %w(world us eu kr tw).freeze
VALID_REGIONS_WITH_REALM = (VALID_REGIONS - ['world']).freeze

REGIONS_SET = Set.new(VALID_REGIONS).freeze
REALM_REGIONS_SET = Set.new(VALID_REGIONS_WITH_REALM).freeze
