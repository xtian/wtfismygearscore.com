# frozen_string_literal: true
class AddAkismetFieldsToComment < ActiveRecord::Migration[5.0]
  def change
    change_table :comments do |t|
      t.string :referrer
      t.string :user_agent
    end
  end
end
