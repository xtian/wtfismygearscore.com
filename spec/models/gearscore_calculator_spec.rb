require 'rails_helper'

RSpec.describe GearscoreCalculator do
  describe '.calculate' do
    let(:character) { Armory::Character.new('us', character_response_body) }

    it 'returns the correct gearscore' do
      expect(described_class.calculate(character.items)).to eq(19_717)
    end
  end
end
