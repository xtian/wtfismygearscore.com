# typed: true
# frozen_string_literal: true

class CreateCharacters < ActiveRecord::Migration[5.0]
  def change
    enable_extension :citext

    create_table :characters do |t|
      t.with_options null: false do |tt|
        tt.integer :region
        tt.citext :realm
        tt.citext :name

        tt.integer :character_class
        tt.integer :level
        tt.integer :score
      end

      t.index %i[name realm region], unique: true
      t.index %i[region score], order: { score: :desc }
      t.index %i[realm region score], order: { score: :desc }
      t.index :score, order: { score: :desc }

      t.timestamps
    end
  end
end
