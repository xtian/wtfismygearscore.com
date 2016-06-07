# frozen_string_literal: true
require 'rails_helper'

RSpec.describe MedianGearscore do
  it { should validate_presence_of :level }

  it { should validate_numericality_of(:level).only_integer.is_greater_than(0) }
  it { should validate_numericality_of(:median_score).is_greater_than_or_equal_to(0) }

  describe '#calculate' do
    subject { described_class.new(level: 100) }

    it 'calculates median score for odd number of characters' do
      Fabricate(:character, level: 100, score: 100)

      subject.calculate

      expect(subject.reload.median_score).to eq(100)
    end

    it 'calculates median score for even number of characters' do
      Fabricate(:character, level: 100, score: 100)
      Fabricate(:character, level: 100, score: 200)

      subject.calculate

      expect(subject.reload.median_score).to eq(150)
    end
  end
end
