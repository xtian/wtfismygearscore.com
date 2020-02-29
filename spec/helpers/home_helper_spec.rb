# typed: false
# frozen_string_literal: true

require "rails_helper"

RSpec.describe HomeHelper do
  describe "#region_options" do
    it "returns valid regions for character lookup" do
      expect(helper.region_options).to eq(
        [
          %w[US us],
          %w[EU eu],
          %w[KR kr],
          %w[TW tw],
        ]
      )
    end
  end
end
