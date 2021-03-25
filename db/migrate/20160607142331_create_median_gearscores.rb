# frozen_string_literal: true

# rubocop:disable Rails/CreateTableWithTimestamps
class CreateMedianGearscores < ActiveRecord::Migration[5.0]
  def change
    create_table :median_gearscores, id: :integer, primary_key: :level do |t|
      t.float :median_score, null: false
    end
  end
end
# rubocop:enable Rails/CreateTableWithTimestamps
