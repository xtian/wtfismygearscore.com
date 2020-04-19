# frozen_string_literal: true

require "rails_helper"

RSpec.describe RefreshStaleCharactersJob do
  describe "#perform" do
    it "enqueues update jobs for cached characters older than a month" do
      Fabricate(:character)
      stale = Fabricate(:character, updated_at: 2.months.ago)

      expect { subject.perform }.to have_enqueued_job(CharacterUpdaterJob).with(stale)
    end

    it "re-enqueues itself" do
      expect { subject.perform }.to have_enqueued_job(described_class)
    end
  end
end
