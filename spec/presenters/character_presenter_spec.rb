# frozen_string_literal: true
require 'rails_helper'

RSpec.describe CharacterPresenter do
  describe '#css_faction' do
    it 'returns "is-alliance" for alliance characters' do
      character = instance_double('Character', faction: 'alliance')
      subject = described_class.new(character)

      expect(subject.css_faction).to eq('is-alliance')
    end

    it 'returns "is-horde" for horde characters' do
      character = instance_double('Character', faction: 'horde')
      subject = described_class.new(character)

      expect(subject.css_faction).to eq('is-horde')
    end
  end

  describe '#rating' do
    it 'returns "win" for characters whose scores are at or above the median' do
      character = instance_double('Character', median_difference: 0)
      subject = described_class.new(character)

      expect(subject.rating).to eq('win')

      character = instance_double('Character', median_difference: 1)
      subject = described_class.new(character)

      expect(subject.rating).to eq('win')
    end

    it 'returns "fail" for characters whose scores are below the median' do
      character = instance_double('Character', median_difference: -1)
      subject = described_class.new(character)

      expect(subject.rating).to eq('fail')
    end
  end
end
