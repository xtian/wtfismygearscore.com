# frozen_string_literal: true
class CreateRealms < ActiveRecord::Migration[5.0]
  def change
    create_table :realms, id: :citext, primary_key: :name do |t|
      t.citext :translations, array: true
    end
  end
end
