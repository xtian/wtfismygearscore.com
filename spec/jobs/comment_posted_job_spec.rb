# frozen_string_literal: true

require "rails_helper"

RSpec.describe CommentPostedJob do
  let(:character) { instance_double("Character") }
  let(:comment) { instance_double("Comment", character: character) }

  describe "#perform" do
    it "deletes a comment if it is spam" do
      allow(Akismet).to receive(:new) { instance_double("Akismet", spam?: true) }
      expect(comment).to receive(:destroy!)
      expect(RecentComment).not_to receive(:refresh)
      expect(CommentNotifier).not_to receive(:call)

      subject.perform(comment)
    end

    it "refreshes recent comments" do
      allow(Akismet).to receive(:new) { instance_double("Akismet", spam?: false) }
      expect(RecentComment).to receive(:refresh)
      expect(CommentNotifier).to receive(:call)

      subject.perform(comment)
    end
  end
end
