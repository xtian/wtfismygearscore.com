# frozen_string_literal: true
class AddGuildNameToCharacter < ActiveRecord::Migration[5.0]
  def change
    change_table :characters do |t|
      t.string :guild_name, null: false
    end
  end
end
