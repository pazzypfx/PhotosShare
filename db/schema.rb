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

ActiveRecord::Schema.define(version: 2018_12_04_173924) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "photos", id: :serial, force: :cascade do |t|
    t.string "path"
    t.integer "user_id"
    t.integer "variety_id"
    t.integer "place_id"
    t.datetime "date"
    t.boolean "published"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["place_id"], name: "index_photos_on_place_id"
    t.index ["user_id"], name: "index_photos_on_user_id"
    t.index ["variety_id"], name: "index_photos_on_variety_id"
  end

  create_table "places", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "place_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "product_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "username"
    t.string "firstName"
    t.string "lastName"
    t.string "email"
    t.string "password_digest"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role"
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "varieties", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "variety_code"
    t.integer "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_varieties_on_product_id"
  end

  add_foreign_key "photos", "places"
  add_foreign_key "photos", "users"
  add_foreign_key "photos", "varieties"
end
