# frozen_string_literal: true
class CommentPostedJob < ApplicationJob
  def perform(comment)
    return comment.destroy! if comment.spam?
    RecentComment.refresh
  end
end
