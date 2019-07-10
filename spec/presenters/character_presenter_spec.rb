# typed: false
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CharacterPresenter do
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
