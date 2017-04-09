# frozen_string_literal: true

class CondenseCharactersIndexes < ActiveRecord::Migration[5.0]
  def up
    change_table :characters do |t|
      t.remove_index [:region, :score]
      t.remove_index [:realm, :region, :score]
      t.remove_index :score

      t.index [:score, :region, :realm, :name], order: { score: :desc }
    end
  end

  def down
    change_table :characters do |t|
      t.index [:region, :score], order: { score: :desc }
      t.index [:realm, :region, :score], order: { score: :desc }
      t.index :score, order: { score: :desc }

      t.remove_index [:score, :region, :realm, :name]
    end
  end
end
