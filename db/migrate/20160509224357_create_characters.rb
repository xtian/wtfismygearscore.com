# frozen_string_literal: true
class CreateCharacters < ActiveRecord::Migration[5.0]
  def change
    enable_extension :citext

    create_table :characters do |t|
      t.with_options null: false do |t|
        t.integer :region
        t.citext :realm
        t.citext :name

        t.integer :character_class
        t.integer :level
        t.integer :score
      end

      t.index [:name, :realm, :region], unique: true
      t.index [:region, :score], order: { score: :desc }
      t.index [:realm, :region, :score], order: { score: :desc }
      t.index :score, order: { score: :desc }

      t.timestamps
    end
  end
end
