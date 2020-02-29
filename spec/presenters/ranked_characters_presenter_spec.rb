# typed: false
# frozen_string_literal: true

require "rails_helper"

RSpec.describe RankedCharactersPresenter do
  subject { described_class.new([], query) }

  let(:characters) do
    [
      instance_double("Character", id: 1),
      instance_double("Character", id: 2),
    ]
  end

  let(:query) { instance_double("RankingQuery", page: 1, per_page: 1, realm: nil) }

  describe "#extra_column_name" do
    it "returns Guild for realm ranking" do
      allow(query).to receive(:realm).and_return("Shadowmoon")

      expect(subject.extra_column_name).to eq("Guild")
    end

    it "returns Realm for region ranking" do
      expect(subject.extra_column_name).to eq("Realm")
    end
  end

  describe "#first_page?" do
    it "returns true if query page is 1" do
      subject = described_class.new(characters, query)

      expect(subject.first_page?).to eq(true)
    end

    it "handles an empty collection" do
      expect(subject.first_page?).to eq(true)
    end
  end

  describe "#last_page?" do
    it "returns true if the ranking contains fewer characters than the per page value" do
      expect(subject.last_page?).to eq(true)
    end

    it "returns false if the ranking contains the same number of characters as the per page value" do
      subject = described_class.new([instance_double("Character")], query)

      expect(subject.last_page?).to eq(false)
    end
  end
end
