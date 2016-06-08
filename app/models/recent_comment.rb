# frozen_string_literal: true
class RecentComment < ApplicationRecord
  def self.refresh
    Scenic.database.refresh_materialized_view(table_name, concurrently: true)
  end

  private

  def readonly?
    true
  end
end
