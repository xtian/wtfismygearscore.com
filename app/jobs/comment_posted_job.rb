# frozen_string_literal: true
class CommentPostedJob < ApplicationJob
  def perform(comment, referrer, user_agent)
    @comment = comment
    @referrer = referrer
    @user_agent = user_agent

    return comment.destroy! if spam?
    RecentComment.refresh
  end

  private

  def spam?
    AKISMET.spam?(@comment, referrer: @referrer, user_agent: @user_agent)
  end
end
