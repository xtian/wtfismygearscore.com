# frozen_string_literal: true

require "spec_helper"
require "armory/character"
require "support/armory_helpers"

RSpec.describe Armory::Character do
  subject { described_class.new(region: "US", profile_body: profile_response_body, equipment_body: equipment_response_body) }

  let(:naked) { described_class.new(region: "us", profile_body: profile_response_body, equipment_body: {}) }

  describe "#avg_ilvl" do
    it "returns the character’s average item level" do
      expect(subject.avg_ilvl).to eq(348)
    end
  end

  describe "#class_name" do
    it "returns character class" do
      expect(subject.class_name).to eq("hunter")
    end
  end

  describe "#faction" do
    it "returns character faction" do
      expect(subject.faction).to eq("alliance")
    end
  end

  describe "#guild" do
    it "returns character guild" do
      expect(subject.guild_name).to eq("The Gentlemens Club")
    end
  end

  describe "#items" do
    it "returns hash of items" do
      expect(subject.items.frozen?).to eq(true)

      keys = subject.items.keys

      expect(keys).to include(:head)
      expect(keys).to include(:chest)
    end
  end

  describe "#name" do
    it "returns character name" do
      expect(subject.name).to eq("Dargonaut")
    end
  end

  describe "#realm" do
    it "returns character realm" do
      expect(subject.realm).to eq("Shadowmoon")
    end
  end

  describe "#region" do
    it "returns character region" do
      expect(subject.region).to eq("us")
    end
  end

  describe "#level" do
    it "returns character level" do
      expect(subject.level).to eq(120)
    end
  end

  describe "#max_ilvl" do
    it "returns the character’s highest item level" do
      expect(subject.max_ilvl).to eq(370)
    end

    it "returns zero if character is naked" do
      expect(naked.max_ilvl).to eq(0)
    end
  end

  describe "#min_ilvl" do
    it "returns the character’s lowest item level" do
      expect(subject.min_ilvl).to eq(325)
    end

    it "returns zero if character is naked" do
      expect(naked.min_ilvl).to eq(0)
    end
  end
end
