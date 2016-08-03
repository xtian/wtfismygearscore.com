# frozen_string_literal: true

# Destroys {Comment} if it registers as spam. Otherwise updates
# {RecentComment} materialized view.
class CommentPostedJob < ApplicationJob
  # @param comment [Comment] posted comment
  # @param referrer [String] referrer for comment post request
  # @param user_agent [String] user agent for poster's browser
  # @return [void]
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
