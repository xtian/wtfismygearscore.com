# frozen_string_literal: true
class CommentPostedJob < ApplicationJob
  def perform(comment)
    return comment.destroy! if Rakismet.key && comment.spam?
    RecentComment.refresh
  end
end
