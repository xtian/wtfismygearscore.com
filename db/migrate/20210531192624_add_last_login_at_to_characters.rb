# frozen_string_literal: true

class AddLastLoginAtToCharacters < ActiveRecord::Migration[5.2]
  def change
    add_column :characters, :last_login_at, :datetime, null: false, default: -> { "now()" }
  end
end
