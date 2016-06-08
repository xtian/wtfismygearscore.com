# frozen_string_literal: true
class CreateRecentComments < ActiveRecord::Migration
  def change
    create_view :recent_comments, materialized: true
    add_index :recent_comments, :comment_id, unique: true
  end
end
