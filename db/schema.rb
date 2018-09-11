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

ActiveRecord::Schema.define(version: 2018_09_11_170740) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
  enable_extension "plpgsql"

  create_table "characters", force: :cascade do |t|
    t.integer "region", null: false
    t.citext "realm", null: false
    t.citext "name", null: false
    t.integer "class_name", null: false
    t.integer "level", null: false
    t.integer "score", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "avg_ilvl", null: false
    t.integer "max_ilvl", null: false
    t.integer "min_ilvl", null: false
    t.string "guild_name"
    t.integer "faction", null: false
    t.datetime "api_updated_at", default: -> { "now()" }, null: false
    t.index ["name", "realm", "region"], name: "index_characters_on_name_and_realm_and_region", unique: true
    t.index ["score", "region", "realm", "name"], name: "index_characters_on_score_and_region_and_realm_and_name", order: { score: :desc }
  end

  create_table "comments", force: :cascade do |t|
    t.text "body", null: false
    t.inet "poster_ip_address", null: false
    t.string "poster_name"
    t.integer "character_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "referrer"
    t.string "user_agent"
    t.index ["character_id", "created_at"], name: "index_comments_on_character_id_and_created_at", order: { created_at: :desc }
  end

  create_table "median_gearscores", primary_key: "level", id: :serial, force: :cascade do |t|
    t.float "median_score", null: false
  end

  create_table "realms", primary_key: "name", id: :citext, force: :cascade do |t|
    t.citext "translations", array: true
  end

  add_foreign_key "comments", "characters", on_delete: :cascade

  create_view "recent_comments", materialized: true,  sql_definition: <<-SQL
      SELECT comments.class_name AS character_class,
      comments.name AS character_name,
      comments.realm AS character_realm,
      comments.region,
      comments.created_at,
      comments.id AS comment_id,
      comments.poster_name
     FROM ( SELECT comments_1.id,
              comments_1.body,
              comments_1.poster_ip_address,
              comments_1.poster_name,
              comments_1.character_id,
              comments_1.created_at,
              comments_1.updated_at,
              characters.class_name,
              characters.name,
              characters.realm,
              characters.region,
              row_number() OVER (PARTITION BY characters.region ORDER BY comments_1.created_at DESC) AS row_number
             FROM (comments comments_1
               JOIN characters ON ((comments_1.character_id = characters.id)))) comments
    WHERE (comments.row_number < 6)
    ORDER BY comments.created_at DESC;
  SQL

  add_index "recent_comments", ["comment_id"], name: "index_recent_comments_on_comment_id", unique: true

end
