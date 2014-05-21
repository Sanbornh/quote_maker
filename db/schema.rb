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

ActiveRecord::Schema.define(version: 20140521181003) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "colour_schemes", force: true do |t|
    t.string   "background"
    t.string   "font"
    t.string   "highlight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "layout_schemes", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.hstore   "layout_parameters"
  end

  create_table "users", force: true do |t|
    t.string   "email",            null: false
    t.string   "crypted_password", null: false
    t.string   "salt",             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  create_table "wallpapers", force: true do |t|
    t.text     "quote"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "colour_scheme_id"
    t.string   "url"
    t.integer  "layout_scheme_id"
    t.integer  "user_id"
  end

end
