# frozen_string_literal: true
require 'rails_helper'

RSpec.describe MedianGearscoreUpdaterJob do
  describe '#perform' do
    it 'calculates a median for each level present in DB' do
      fabricate_character(level: 1)
      fabricate_character(level: 100)

      expect(MedianGearscore.count).to eq(0)

      expect {
        subject.perform
      }.to have_enqueued_job(described_class)

      expect(MedianGearscore.count).to eq(2)
    end
  end
end
