# frozen_string_literal: true

# rubocop:disable Rails/BulkChangeTable
class AddApiIdToCharacters < ActiveRecord::Migration[6.0]
  def up
    add_column :characters, :api_id, :integer
    remove_column :characters, :api_updated_at
  end

  def down
    add_column :characters, :api_updated_at, :datetime, null: false, default: -> { "now()" }
    remove_column :characters, :api_id
  end
end
# rubocop:enable Rails/BulkChangeTable
