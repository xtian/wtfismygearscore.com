# frozen_string_literal: true

class AddFactionToCharacters < ActiveRecord::Migration[5.0]
  def change
    add_column :characters, :faction, :integer, null: false
  end
end
