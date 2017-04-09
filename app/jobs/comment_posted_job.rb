# frozen_string_literal: true

require 'akismet'

# Destroys {Comment} if it registers as spam. Otherwise updates
# {RecentComment} materialized view.
class CommentPostedJob < ApplicationJob
  # @param comment [Comment] posted comment
  # @param referrer [String] referrer for comment post request
  # @param user_agent [String] user agent for poster's browser
  # @return [void]
  def perform(comment)
    return comment.destroy! if spam?(comment)

    CommentNotifier.call(comment, comment.character)
    RecentComment.refresh
  end

  private

  def spam?(comment)
    key = Rails.application.secrets.akismet_key
    url = Rails.application.secrets.akismet_url

    return false unless key && url

    akismet = Akismet.new(key: key, url: url, is_test: Rails.env.in?(%w[development test]))
    akismet.spam?(comment)
  end
end
