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

ActiveRecord::Schema.define(version: 20150620145645) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "citext"

  create_table "card_decks", force: :cascade do |t|
    t.integer  "deck_id"
    t.integer  "card_id"
    t.integer  "copies",                 default: 1
    t.string   "part",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cards", force: :cascade do |t|
    t.string   "name",             limit: 255
    t.string   "image",            limit: 255
    t.string   "set",              limit: 255
    t.string   "mana_cost",        limit: 255
    t.string   "ctype",            limit: 255
    t.integer  "power"
    t.integer  "toughness"
    t.string   "rarity",           limit: 255
    t.string   "artist",           limit: 255
    t.integer  "number"
    t.string   "number_ex",        limit: 255
    t.string   "original_type",    limit: 255
    t.string   "layout",           limit: 255
    t.string   "border",           limit: 255
    t.string   "portuguese_name",  limit: 255
    t.text     "original_text"
    t.text     "flavor"
    t.integer  "loyalty"
    t.integer  "multiverse_id"
    t.integer  "cmc"
    t.string   "ctypes",                       default: [], array: true
    t.string   "subtypes",                     default: [], array: true
    t.string   "printings",                    default: [], array: true
    t.string   "names",                        default: [], array: true
    t.string   "colors",                       default: [], array: true
    t.string   "supertypes",                   default: [], array: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "price"
    t.datetime "price_updated_at"
  end

  create_table "collections", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.jsonb    "list"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "decks", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description"
    t.string   "url",         limit: 255
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "season",      limit: 255
    t.string   "source",      limit: 255
    t.jsonb    "list"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",               default: 0, null: false
    t.integer  "attempts",               default: 0, null: false
    t.text     "handler",                            null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "inventories", force: :cascade do |t|
    t.integer  "copies"
    t.integer  "card_id"
    t.integer  "user_id"
    t.integer  "language_id"
    t.boolean  "foil"
    t.string   "price",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "list",        limit: 255
  end

  create_table "prices", force: :cascade do |t|
    t.integer  "card_id"
    t.decimal  "value"
    t.string   "source",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "prices", ["card_id"], name: "index_prices_on_card_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "login",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
