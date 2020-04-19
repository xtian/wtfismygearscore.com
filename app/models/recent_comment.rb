# frozen_string_literal: true

# Materialized view which caches a limited number of recent comments for
# display so that an index does not have to be maintained across the entire
# comments table
class RecentComment < ApplicationRecord
  # Refreshes materialized view
  # @return [void]
  def self.refresh
    Scenic.database.refresh_materialized_view(table_name, concurrently: true)
  end

  private

  def readonly?
    true
  end
end
