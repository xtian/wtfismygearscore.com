require 'rails_helper'

RSpec.describe Character do
  it { should define_enum_for(:class_name).with(CLASSES) }
  it { should define_enum_for(:region).with(VALID_REGIONS_WITH_REALM) }

  %i(avg_ilvl class_name level max_ilvl min_ilvl name realm region score).each do |field|
    it { should validate_presence_of(field) }
  end

  %i(avg_ilvl level max_ilvl min_ilvl score).each do |field|
    it { should validate_numericality_of(field).only_integer.is_greater_than(0) }
  end

  it { should have_db_index([:name, :realm, :region]).unique }
  it { should have_db_index([:realm, :region, :score]) }
  it { should have_db_index([:region, :score]) }
  it { should have_db_index(:score) }

  describe '#update_from_armory' do
    it 'stores score and information from Armory::Character' do
      character = Fabricate.build(:character)
      fields = %i(avg_ilvl class_name level max_ilvl min_ilvl name realm)

      armory_character = instance_double('Armory::Character', character.slice(*fields))
      allow(armory_character).to receive(:guild_name).and_return('Green Street Elite')

      character.update_from_armory(armory_character, 100)

      expect(character.new_record?).to eq(false)
      expect(character.score).to eq(100)
      expect(character.guild_name).to eq('Green Street Elite')
    end
  end
end
