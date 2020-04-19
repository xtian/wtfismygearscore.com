# typed: false
# frozen_string_literal: true

require "rails_helper"

RSpec.describe GearscoreCalculator do
  describe ".calculate" do
    it "returns the correct gearscore for a two-hand user" do
      character = Armory::Character.new(region: "us", profile_body: profile_response_body, equipment_body: equipment_response_body)
      expect(described_class.calculate(character.items)).to eq(8641)
    end
  end
end
