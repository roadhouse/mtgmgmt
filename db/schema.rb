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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130527022141) do

  create_table "card_decks", :force => true do |t|
    t.integer  "deck_id"
    t.integer  "card_id"
    t.integer  "copies",     :default => 1
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "cards", :force => true do |t|
    t.string   "name"
    t.string   "image"
    t.string   "set"
    t.string   "color"
    t.string   "manacost"
    t.string   "card_type"
    t.string   "power"
    t.string   "toughness"
    t.string   "rarity"
    t.string   "artist"
    t.string   "number"
    t.string   "number_ex"
    t.integer  "edition_id"
    t.integer  "loyalty"
    t.text     "text"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "decks", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "inventories", :force => true do |t|
    t.integer  "quantity"
    t.integer  "card_id"
    t.integer  "user_id"
    t.integer  "language_id"
    t.boolean  "foil"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
