# frozen_string_literal: true
require 'rails_helper'

RSpec.describe CommentPostedJob do
  describe '#perform' do
    it 'deletes a comment if it is spam' do
      comment = instance_double('Comment', spam?: true)

      expect(comment).to receive(:destroy!)
      expect(RecentComment).not_to receive(:refresh)

      subject.perform(comment)
    end

    it 'refreshes recent comments' do
      comment = instance_double('Comment', spam?: false)

      expect(RecentComment).to receive(:refresh)

      subject.perform(comment)
    end
  end
end
