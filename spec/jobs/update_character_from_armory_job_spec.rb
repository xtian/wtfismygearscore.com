require 'rails_helper'
require 'support/armory_helpers'

RSpec.describe UpdateCharacterFromArmoryJob do
  before do
    stub_character_request
  end

  describe '#perform' do
    it 'updates DB from the Armory' do
      character = Fabricate(
        :character,
        score: 1,
        level: 1,
        updated_at: 1.week.ago
      )

      subject.perform(character)

      expect(character.reload.score).to eq(19_717)
      expect(character.level).to eq(100)
    end

    it 'does nothing if character was recently updated' do
      character = Fabricate(
        :character,
        score: 1,
        level: 1
      )

      subject.perform(character)

      expect(character.reload.score).to eq(1)
    end
  end
end
