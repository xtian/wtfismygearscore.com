# frozen_string_literal: true
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

ActiveRecord::Schema.define(version: 20160608192000) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "citext"

  create_table "characters", force: :cascade do |t|
    t.integer  "region",     null: false
    t.citext   "realm",      null: false
    t.citext   "name",       null: false
    t.integer  "class_name", null: false
    t.integer  "level",      null: false
    t.integer  "score",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "avg_ilvl",   null: false
    t.integer  "max_ilvl",   null: false
    t.integer  "min_ilvl",   null: false
    t.string   "guild_name"
    t.integer  "faction",    null: false
    t.index ["name", "realm", "region"], name: "index_characters_on_name_and_realm_and_region", unique: true, using: :btree
    t.index ["realm", "region", "score"], name: "index_characters_on_realm_and_region_and_score", order: {"score"=>:desc}, using: :btree
    t.index ["region", "score"], name: "index_characters_on_region_and_score", order: {"score"=>:desc}, using: :btree
    t.index ["score"], name: "index_characters_on_score", order: {"score"=>:desc}, using: :btree
  end

  create_table "comments", force: :cascade do |t|
    t.text     "body",              null: false
    t.inet     "poster_ip_address", null: false
    t.string   "poster_name"
    t.integer  "character_id",      null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["character_id", "created_at"], name: "index_comments_on_character_id_and_created_at", order: {"created_at"=>:desc}, using: :btree
  end

  create_table "median_gearscores", primary_key: "level", id: :integer, force: :cascade do |t|
    t.float "median_score", null: false
  end

  add_foreign_key "comments", "characters", on_delete: :cascade
end
