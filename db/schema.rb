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

ActiveRecord::Schema.define(version: 20161218221725) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "locations", force: :cascade do |t|
    t.integer  "user_id",        null: false
    t.string   "street_address", null: false
    t.string   "city",           null: false
    t.string   "state",          null: false
    t.string   "zip",            null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "ratings", force: :cascade do |t|
    t.integer  "reservation_id", null: false
    t.integer  "user_id",        null: false
    t.integer  "rater_id",       null: false
    t.integer  "score"
    t.string   "comment"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "reservations", force: :cascade do |t|
    t.integer  "space_id",    null: false
    t.integer  "occupant_id", null: false
    t.datetime "start_time",  null: false
    t.datetime "end_time",    null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "spaces", force: :cascade do |t|
    t.integer  "location_id",                       null: false
    t.string   "size",         default: "standard"
    t.string   "description"
    t.integer  "space_active", default: 0
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name",                       null: false
    t.string   "last_name",                        null: false
    t.string   "email",                            null: false
    t.string   "password_digest",                  null: false
    t.string   "phone",                            null: false
    t.string   "status",          default: "user"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

end
