# frozen_string_literal: true

class CreateRealms < ActiveRecord::Migration[5.0]
  def up
    # rubocop:disable Rails/CreateTableWithTimestamps
    create_table :realms, id: :citext, primary_key: :name do |t|
      t.citext :translations, array: true
    end
    # rubocop:enable Rails/CreateTableWithTimestamps

    realms = YAML.load_file(Rails.root.join('db', 'seeds', 'realms.yml'))
    Realm.create!(realms)
  end

  def down
    drop_table :realms
  end
end
