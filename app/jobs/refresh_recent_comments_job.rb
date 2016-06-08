# frozen_string_literal: true
class RefreshRecentCommentsJob < ApplicationJob
  def perform
    RecentComment.refresh
  end
end
