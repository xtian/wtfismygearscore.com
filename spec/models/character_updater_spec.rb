require 'rails_helper'
require 'support/armory_helpers'

RSpec.describe CharacterUpdater do
  before do
    stub_character_request
  end

  describe '.call' do
    let(:character) do
      instance_double('Character', region: 'us', realm: 'shadowmoon', name: 'dargonaut')
    end

    it 'saves a new record with data from the Armory' do
      allow(character).to receive(:new_record?).and_return(true)

      expect(character).to receive(:update_from_armory)
        .with(duck_type(:level, :class_name, :guild_name), 19_717)

      return_value = described_class.call(character)

      expect(return_value).to eq(character)
    end

    it 'updates an outdated record with data from the Armory' do
      allow(character).to receive(:new_record?).and_return(false)
      allow(character).to receive(:updated_at).and_return(1.week.ago)

      expect(character).to receive(:update_from_armory)

      described_class.call(character)
    end

    it 'does nothing if character was recently updated' do
      allow(character).to receive(:new_record?).and_return(false)
      allow(character).to receive(:updated_at).and_return(Time.current)

      expect(character).not_to receive(:update_from_armory)

      return_value = described_class.call(character)

      expect(return_value).to eq(character)
    end
  end
end
