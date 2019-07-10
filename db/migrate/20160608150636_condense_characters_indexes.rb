# typed: true
# frozen_string_literal: true

class CondenseCharactersIndexes < ActiveRecord::Migration[5.0]
  def up
    change_table :characters do |t|
      t.remove_index %i[region score]
      t.remove_index %i[realm region score]
      t.remove_index :score

      t.index %i[score region realm name], order: { score: :desc }
    end
  end

  def down
    change_table :characters do |t|
      t.index %i[region score], order: { score: :desc }
      t.index %i[realm region score], order: { score: :desc }
      t.index :score, order: { score: :desc }

      t.remove_index %i[score region realm name]
    end
  end
end
