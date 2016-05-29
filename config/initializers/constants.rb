SITE_NAME = 'WTF is My Gear Score?'.freeze

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
  'druid'
].freeze

VALID_REGIONS = %w(world us eu kr tw cn).freeze
VALID_REGIONS_WITH_REALM = (VALID_REGIONS - ['world']).freeze
