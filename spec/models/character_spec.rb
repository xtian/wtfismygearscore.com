require 'rails_helper'

RSpec.describe Character do
  it { should define_enum_for(:character_class).with(CLASSES) }
  it { should define_enum_for(:region).with(VALID_REGIONS_WITH_REALM) }

  it { should validate_presence_of(:character_class) }
  it { should validate_presence_of(:level) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:realm) }
  it { should validate_presence_of(:region) }
  it { should validate_presence_of(:score) }

  it { should validate_numericality_of(:level).only_integer.is_greater_than(0) }
  it { should validate_numericality_of(:score).only_integer.is_greater_than(0) }

  it { should have_db_index([:name, :realm, :region]).unique }
  it { should have_db_index([:realm, :region, :score]) }
  it { should have_db_index([:region, :score]) }
  it { should have_db_index(:score) }
end
