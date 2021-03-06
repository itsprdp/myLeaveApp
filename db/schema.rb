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

ActiveRecord::Schema.define(version: 20190827105623) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "holidays", force: :cascade do |t|
    t.date     "date"
    t.string   "occasion"
    t.integer  "ooo_config_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.datetime "deleted_at"
    t.index ["ooo_config_id"], name: "index_holidays_on_ooo_config_id", using: :btree
  end

  create_table "ooo_configs", force: :cascade do |t|
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "financial_year"
    t.integer  "leaves_count"
    t.integer  "wfhs_count"
    t.integer  "wfh_penalty_coefficient"
    t.float    "wfh_headsup_hours"
    t.datetime "deleted_at"
    t.index ["financial_year"], name: "index_ooo_configs_on_financial_year", unique: true, using: :btree
  end

  create_table "ooo_periods", force: :cascade do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "user_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "google_event_id"
    t.string   "type"
    t.datetime "deleted_at"
    t.boolean  "skip_penalty",    default: false
    t.index ["user_id"], name: "index_ooo_periods_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "email"
    t.boolean  "admin"
    t.date     "joining_date"
    t.integer  "token_expires_at"
    t.boolean  "active",                   default: true
    t.string   "employee_id"
    t.date     "dob"
    t.date     "leaving_date"
    t.string   "fathers_name"
    t.string   "adhaar_number"
    t.string   "pan_number"
    t.string   "blood_group"
    t.string   "emergency_contact_number"
    t.string   "mailing_address"
    t.string   "personal_email"
    t.string   "contact_number"
    t.string   "passport_number"
  end

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  limit: 191, null: false
    t.integer  "item_id",                null: false
    t.string   "event",                  null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree
  end

  add_foreign_key "holidays", "ooo_configs"
  add_foreign_key "ooo_periods", "users"
end
