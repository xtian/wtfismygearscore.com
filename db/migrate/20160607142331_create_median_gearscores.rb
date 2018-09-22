# frozen_string_literal: true

class CreateMedianGearscores < ActiveRecord::Migration[5.0]
  def change
    # rubocop:disable Rails/CreateTableWithTimestamps
    create_table :median_gearscores, id: :integer, primary_key: :level do |t|
      t.float :median_score, null: false
    end
    # rubocop:enable Rails/CreateTableWithTimestamps
  end
end
