# frozen_string_literal: true

# rubocop:disable Rails/NotNullColumn
class AddFactionToCharacters < ActiveRecord::Migration[5.0]
  def change
    add_column :characters, :faction, :integer, null: false
  end
end
# rubocop:enable Rails/NotNullColumn
