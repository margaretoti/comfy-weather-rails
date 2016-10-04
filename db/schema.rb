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

ActiveRecord::Schema.define(version: 20161004193017) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "article_of_clothings", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "description", null: false
    t.uuid     "user_id",     null: false
    t.uuid     "category_id", null: false
  end

  add_index "article_of_clothings", ["category_id"], name: "index_article_of_clothings_on_category_id", using: :btree
  add_index "article_of_clothings", ["user_id"], name: "index_article_of_clothings_on_user_id", using: :btree

  create_table "categories", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "name",                         null: false
    t.string   "unselected_icon_file_name",    null: false
    t.string   "unselected_icon_content_type", null: false
    t.integer  "unselected_icon_file_size",    null: false
    t.datetime "unselected_icon_updated_at",   null: false
    t.string   "selected_icon_file_name",      null: false
    t.string   "selected_icon_content_type",   null: false
    t.integer  "selected_icon_file_size",      null: false
    t.datetime "selected_icon_updated_at",     null: false
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "outfit_article_of_clothings", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.uuid     "outfit_id",              null: false
    t.uuid     "article_of_clothing_id", null: false
  end

  add_index "outfit_article_of_clothings", ["article_of_clothing_id"], name: "index_outfit_article_of_clothings_on_article_of_clothing_id", using: :btree
  add_index "outfit_article_of_clothings", ["outfit_id"], name: "index_outfit_article_of_clothings_on_outfit_id", using: :btree

  create_table "outfit_weather_types", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "rating",          null: false
    t.uuid     "outfit_id",       null: false
    t.uuid     "weather_type_id", null: false
  end

  add_index "outfit_weather_types", ["outfit_id"], name: "index_outfit_weather_types_on_outfit_id", using: :btree
  add_index "outfit_weather_types", ["weather_type_id"], name: "index_outfit_weather_types_on_weather_type_id", using: :btree

  create_table "outfits", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.text     "notes"
    t.boolean  "is_public"
    t.uuid     "user_id"
    t.decimal  "longitude",          null: false
    t.decimal  "latitude",           null: false
  end

  add_index "outfits", ["user_id"], name: "index_outfits_on_user_id", using: :btree

  create_table "users", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "email"
    t.integer  "gender"
    t.time     "preferred_time"
    t.integer  "weather_perception",  default: 1
    t.string   "provider",                        null: false
    t.string   "uid",                             null: false
    t.string   "name",                            null: false
    t.string   "auth_token",                      null: false
    t.datetime "auth_expires_at",                 null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  create_table "weather_types", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.datetime  "created_at",  null: false
    t.datetime  "updated_at",  null: false
    t.int4range "temp_range",  null: false
    t.integer   "precip_type"
  end

  add_foreign_key "article_of_clothings", "categories"
  add_foreign_key "article_of_clothings", "users"
  add_foreign_key "outfit_article_of_clothings", "article_of_clothings"
  add_foreign_key "outfit_article_of_clothings", "outfits"
  add_foreign_key "outfit_weather_types", "outfits"
  add_foreign_key "outfit_weather_types", "weather_types"
  add_foreign_key "outfits", "users"
end
