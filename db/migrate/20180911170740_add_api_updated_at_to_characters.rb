# frozen_string_literal: true

class AddApiUpdatedAtToCharacters < ActiveRecord::Migration[5.2]
  def change
    add_column :characters, :api_updated_at, :datetime, null: false, default: -> { "now()" }
  end
end
