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

ActiveRecord::Schema.define(version: 20180804155530) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "coffee_houses", force: :cascade do |t|
    t.string "name", null: false
    t.float "latitude", null: false
    t.float "longitude", null: false
    t.string "address", null: false
    t.string "description"
    t.bigint "owner_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["latitude", "longitude"], name: "index_coffee_houses_on_latitude_and_longitude"
    t.index ["owner_id"], name: "index_coffee_houses_on_owner_id"
  end

  create_table "coffees", force: :cascade do |t|
    t.string "name", null: false
    t.string "type", null: false
    t.integer "volume", null: false
    t.decimal "price", precision: 10, scale: 2, null: false
    t.string "description"
    t.bigint "coffee_house_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coffee_house_id"], name: "index_coffees_on_coffee_house_id"
  end

  create_table "providers", force: :cascade do |t|
    t.string "name", null: false
    t.string "uid", null: false
    t.bigint "user_id", null: false
    t.index ["uid", "name"], name: "index_providers_on_uid_and_name", unique: true
    t.index ["user_id", "name"], name: "index_providers_on_user_id_and_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "full_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "coffee_houses", "users", column: "owner_id"
  add_foreign_key "coffees", "coffee_houses"
  add_foreign_key "providers", "users"
end
