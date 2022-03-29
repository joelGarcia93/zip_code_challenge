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

ActiveRecord::Schema.define(version: 2022_03_29_034157) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "colonies", force: :cascade do |t|
    t.string "zip_code_id", null: false
    t.string "code", null: false
    t.string "name", null: false
    t.string "description"
    t.index ["name", "code", "zip_code_id"], name: "idx_on_name_code_and_postal_code_id", unique: true
    t.index ["zip_code_id"], name: "index_colonies_on_zip_code_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name", null: false
    t.string "code", null: false
    t.string "code2", null: false
    t.string "description"
    t.index ["code"], name: "index_countries_on_code", unique: true
    t.index ["name"], name: "index_countries_on_name", unique: true
  end

  create_table "municipalities", force: :cascade do |t|
    t.string "state_id", null: false
    t.string "code", null: false
    t.string "name", null: false
    t.string "description"
    t.index ["state_id", "code"], name: "index_municipalities_on_state_id_and_code", unique: true
    t.index ["state_id"], name: "index_municipalities_on_state_id"
  end

  create_table "states", id: :string, force: :cascade do |t|
    t.bigint "country_id", null: false
    t.string "code"
    t.string "code2", null: false
    t.string "name", null: false
    t.string "description"
    t.index ["code2"], name: "index_states_on_code2", unique: true
    t.index ["country_id"], name: "index_states_on_country_id"
    t.index ["name"], name: "index_states_on_name", unique: true
  end

  create_table "zip_codes", id: :string, force: :cascade do |t|
    t.bigint "municipality_id", null: false
    t.string "code", null: false
    t.string "name", null: false
    t.string "description"
    t.index ["code"], name: "index_zip_codes_on_code", unique: true
    t.index ["municipality_id"], name: "index_zip_codes_on_municipality_id"
    t.index ["name"], name: "index_zip_codes_on_name", unique: true
  end

  add_foreign_key "colonies", "zip_codes"
  add_foreign_key "municipalities", "states"
  add_foreign_key "states", "countries"
  add_foreign_key "zip_codes", "municipalities"
end
