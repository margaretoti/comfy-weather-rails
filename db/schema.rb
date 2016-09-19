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

ActiveRecord::Schema.define(version: 20160916131945) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

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

<<<<<<< HEAD
<<<<<<< HEAD
  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.integer  "gender"
    t.time     "preferred_time"
    t.integer  "weather_perception", default: 1
    t.string   "provider",                       null: false
    t.string   "uid",                            null: false
    t.string   "name",                           null: false
    t.string   "oauth_token",                    null: false
    t.datetime "oauth_expires_at",               null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
=======
  create_table "outfits", force: :cascade do |t|
    t.integer  "rating"
    t.string   "notes"
    t.boolean  "is_public"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
>>>>>>> fadc19f... created the outfit model
=======
  create_table "outfits", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "rating",             null: false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.text     "notes"
    t.boolean  "is_public"
>>>>>>> f29c9d3... added uuid and adjusted migration and model to include photo using paperclip and a notes limit. rspec tests fail due to uuid error
  end

end
