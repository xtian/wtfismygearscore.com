# frozen_string_literal: true

class AddFactionToCharacters < ActiveRecord::Migration[5.0]
  def change
    # rubocop:disable Rails/NotNullColumn
    add_column :characters, :faction, :integer, null: false
    # rubocop:enable Rails/NotNullColumn
  end
end
