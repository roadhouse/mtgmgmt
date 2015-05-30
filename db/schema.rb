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

ActiveRecord::Schema.define(version: 20150530195455) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "card_decks", force: true do |t|
    t.integer  "deck_id"
    t.integer  "card_id"
    t.integer  "copies",     default: 1
    t.string   "part"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cards", force: true do |t|
    t.string   "name"
    t.string   "image"
    t.string   "set"
    t.string   "mana_cost"
    t.string   "ctype"
    t.string   "power"
    t.integer  "toughness"
    t.string   "rarity"
    t.string   "artist"
    t.integer  "number"
    t.string   "number_ex"
    t.string   "original_type"
    t.string   "layout"
    t.string   "border"
    t.string   "portuguese_name"
    t.text     "original_text"
    t.text     "flavor"
    t.integer  "loyalty"
    t.integer  "multiverse_id"
    t.integer  "cmc"
    t.string   "ctypes",           default: [], array: true
    t.string   "subtypes",         default: [], array: true
    t.string   "printings",        default: [], array: true
    t.string   "names",            default: [], array: true
    t.string   "colors",           default: [], array: true
    t.string   "supertypes",       default: [], array: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "price"
    t.datetime "price_updated_at"
  end

  create_table "decks", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "url"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "season"
    t.string   "source"
  end

  create_table "delayed_jobs", force: true do |t|
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

  create_table "inventories", force: true do |t|
    t.integer  "copies"
    t.integer  "card_id"
    t.integer  "user_id"
    t.integer  "language_id"
    t.boolean  "foil"
    t.string   "price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "list"
  end

  create_table "prices", force: true do |t|
    t.integer "card_id"
    t.decimal "value"
  end

  add_index "prices", ["card_id"], name: "index_prices_on_card_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "login"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
