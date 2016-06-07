# frozen_string_literal: true
class AddColumnsToCharacter < ActiveRecord::Migration[5.0]
  def change
    change_table :characters do |t|
      t.integer :avg_ilvl, null: false
      t.integer :max_ilvl, null: false
      t.integer :min_ilvl, null: false

      t.rename :character_class, :class_name
    end
  end
end
