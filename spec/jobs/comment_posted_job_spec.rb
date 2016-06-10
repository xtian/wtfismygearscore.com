# frozen_string_literal: true
require 'rails_helper'

RSpec.describe CommentPostedJob do
  let(:comment) { instance_double('Comment') }

  describe '#perform' do
    it 'deletes a comment if it is spam' do
      expect(AKISMET).to receive(:spam?).with(comment, referrer: 'foo', user_agent: 'bar') { true }
      expect(comment).to receive(:destroy!)
      expect(RecentComment).not_to receive(:refresh)

      subject.perform(comment, 'foo', 'bar')
    end

    it 'refreshes recent comments' do
      allow(AKISMET).to receive(:spam?).with(comment, referrer: 'foo', user_agent: 'bar') { false }
      expect(RecentComment).to receive(:refresh)

      subject.perform(comment, 'foo', 'bar')
    end
  end
end
