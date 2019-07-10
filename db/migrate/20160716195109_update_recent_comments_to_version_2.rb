# typed: false
# frozen_string_literal: true

class UpdateRecentCommentsToVersion2 < ActiveRecord::Migration
  def change
    update_view :recent_comments, version: 2, revert_to_version: 1, materialized: true
  end
end
