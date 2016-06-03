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
].map(&:freeze).freeze

VALID_REGIONS = %w(world us eu kr tw cn).map(&:freeze).freeze
VALID_REGIONS_WITH_REALM = (VALID_REGIONS - ['world']).freeze
