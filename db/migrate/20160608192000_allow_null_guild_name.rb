# frozen_string_literal: true

class AllowNullGuildName < ActiveRecord::Migration[5.0]
  def change
    change_column :characters, :guild_name, :string, null: true
  end
end
