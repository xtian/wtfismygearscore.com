# frozen_string_literal: true

class UpdateRecentCommentsToVersion3 < ActiveRecord::Migration
  def change
    update_view :recent_comments, version: 3, revert_to_version: 2, materialized: true
  end
end
