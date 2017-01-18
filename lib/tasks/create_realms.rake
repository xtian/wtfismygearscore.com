# frozen_string_literal: true
require 'yaml'

desc 'Create Realms from realms.yml seed file'
task create_realms: :environment do
  Realm.destroy_all
  Realm.create! YAML.load_file(Rails.root.join('db', 'seeds', 'realms.yml'))
end
