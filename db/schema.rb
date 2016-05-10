# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160509224357) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "citext"

  create_table "characters", force: :cascade do |t|
    t.integer  "region",          null: false
    t.citext   "realm",           null: false
    t.citext   "name",            null: false
    t.integer  "character_class", null: false
    t.integer  "level",           null: false
    t.integer  "score",           null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["name", "realm", "region"], name: "index_characters_on_name_and_realm_and_region", unique: true, using: :btree
    t.index ["realm", "region", "score"], name: "index_characters_on_realm_and_region_and_score", order: {"score"=>:desc}, using: :btree
    t.index ["region", "score"], name: "index_characters_on_region_and_score", order: {"score"=>:desc}, using: :btree
    t.index ["score"], name: "index_characters_on_score", order: {"score"=>:desc}, using: :btree
  end

end
