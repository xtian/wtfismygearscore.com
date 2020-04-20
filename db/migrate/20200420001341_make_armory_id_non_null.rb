# frozen_string_literal: true

class MakeArmoryIdNonNull < ActiveRecord::Migration[6.0]
  def up
    change_column :characters, :api_id, :integer, null: false
  end

  def down
    change_column :characters, :api_id, :integer, null: true
  end
end
