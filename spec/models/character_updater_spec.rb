# frozen_string_literal: true
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
      allow(character).to receive(:new_record?) { true }

      expect(character).to receive(:update_from_armory)
        .with(duck_type(:level, :class_name, :guild_name), 19_891)

      return_value = described_class.call(character)

      expect(return_value).to eq(character)
    end

    it 'updates an outdated record with data from the Armory' do
      freeze_time do
        allow(character).to receive(:new_record?) { false }
        allow(character).to receive(:updated_at) { 15.minutes.ago }

        expect(character).to receive(:update_from_armory)

        described_class.call(character)
      end
    end

    it 'does nothing if character was recently updated' do
      allow(character).to receive(:new_record?) { false }
      allow(character).to receive(:updated_at) { 14.minutes.ago }

      expect(character).not_to receive(:update_from_armory)

      return_value = described_class.call(character)
      expect(return_value).to eq(character)
    end

    it 'handles not found errors' do
      allow(character).to receive(:new_record?) { false }
      allow(character).to receive(:updated_at) { 15.minutes.ago }
      expect(character).to receive(:destroy!)

      allow(ARMORY).to receive(:fetch_character).and_raise(Armory::NotFoundError)

      described_class.call(character)
    end

    it 'reraises not found errors for new records' do
      allow(character).to receive(:new_record?) { true }

      allow(ARMORY).to receive(:fetch_character).and_raise(Armory::NotFoundError)

      expect {
        described_class.call(character)
      }.to raise_error(Armory::NotFoundError)
    end
  end
end
