# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MedianGearscore do
  it { is_expected.to validate_presence_of :level }

  it { is_expected.to validate_numericality_of(:level).only_integer.is_greater_than(0) }
  it { is_expected.to validate_numericality_of(:median_score) }

  describe '#median_score' do
    it 'defaults to zero' do
      subject = described_class.new
      expect(subject.median_score).to eq(0)

      subject.median_score = 1
      expect(subject.median_score).to eq(1)
    end
  end

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
