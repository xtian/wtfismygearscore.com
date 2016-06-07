# frozen_string_literal: true
require 'rails_helper'

RSpec.describe GearscoreCalculator do
  describe '.calculate' do
    it 'returns the correct gearscore for a two-hand user' do
      character = Armory::Character.new('us', character_response_body)
      expect(described_class.calculate(character.items)).to eq(19_717)
    end

    it 'returns the correct gearscore for a dual-wielder' do
      character = Armory::Character.new('us', alternate_character_response_body)
      expect(described_class.calculate(character.items)).to eq(15_059)
    end
  end
end
