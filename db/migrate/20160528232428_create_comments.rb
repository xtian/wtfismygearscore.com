# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.text :body, null: false
      t.inet :poster_ip_address, null: false
      t.string :poster_name

      t.belongs_to :character, null: false, index: false
      t.timestamps

      t.index [:character_id, :created_at], order: { created_at: :desc }
    end

    add_foreign_key :comments, :characters, on_delete: :cascade
  end
end
