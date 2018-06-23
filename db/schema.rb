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

ActiveRecord::Schema.define(version: 2016_01_06_132708) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
  enable_extension "plpgsql"

  create_table "cards", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "image"
    t.string "set"
    t.string "mana_cost"
    t.string "ctype"
    t.integer "power"
    t.integer "toughness"
    t.string "rarity"
    t.string "artist"
    t.integer "number"
    t.string "number_ex"
    t.string "original_type"
    t.string "layout"
    t.string "border"
    t.string "portuguese_name"
    t.text "original_text"
    t.text "flavor"
    t.integer "loyalty"
    t.integer "multiverse_id"
    t.integer "cmc"
    t.string "ctypes", default: [], array: true
    t.string "subtypes", default: [], array: true
    t.string "printings", default: [], array: true
    t.string "names", default: [], array: true
    t.string "colors", default: [], array: true
    t.string "supertypes", default: [], array: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal "price"
    t.datetime "price_updated_at"
    t.boolean "is_standard"
  end

  create_table "collections", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "name"
    t.jsonb "list"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "decks", id: :serial, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "url"
    t.date "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "season"
    t.string "source"
    t.jsonb "list"
  end

  create_table "delayed_jobs", id: :serial, force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "inventories", id: :serial, force: :cascade do |t|
    t.integer "copies"
    t.integer "card_id"
    t.integer "user_id"
    t.integer "language_id"
    t.boolean "foil"
    t.string "price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "list"
  end

  create_table "prices", id: :serial, force: :cascade do |t|
    t.integer "card_id"
    t.decimal "value"
    t.string "source"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["card_id"], name: "index_prices_on_card_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "login"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "provider"
    t.string "uid"
    t.string "avatar"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["provider"], name: "index_users_on_provider"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid"], name: "index_users_on_uid"
  end

end
