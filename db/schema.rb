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

ActiveRecord::Schema.define(version: 2018_05_03_201217) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "administrative_assistants", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "phone_number"
    t.string "mail_stop"
    t.string "address"
    t.bigint "administrator_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["administrator_id"], name: "index_administrative_assistants_on_administrator_id"
  end

  create_table "administrators", force: :cascade do |t|
    t.string "job_title"
    t.string "title"
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "phone_number"
    t.string "mail_stop"
    t.string "sec_loc"
    t.boolean "interim"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "current", default: false
    t.bigint "institutional_unit_id"
    t.string "type"
    t.bigint "department_id"
    t.bigint "institution_id"
    t.index ["department_id"], name: "index_administrators_on_department_id"
    t.index ["institution_id"], name: "index_administrators_on_institution_id"
    t.index ["institutional_unit_id"], name: "index_administrators_on_institutional_unit_id"
    t.index ["type"], name: "index_administrators_on_type"
  end

  create_table "departments", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.bigint "institution_id"
    t.bigint "institutional_unit_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["institution_id"], name: "index_departments_on_institution_id"
    t.index ["institutional_unit_id"], name: "index_departments_on_institutional_unit_id"
    t.index ["slug"], name: "index_departments_on_slug", unique: true
  end

  create_table "institutional_units", force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "institution_id"
    t.index ["institution_id"], name: "index_institutional_units_on_institution_id"
    t.index ["slug"], name: "index_institutional_units_on_slug", unique: true
  end

  create_table "institutions", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_institutions_on_slug", unique: true
  end

  create_table "notes", force: :cascade do |t|
    t.text "text"
    t.bigint "institution_id"
    t.bigint "institutional_unit_id"
    t.bigint "department_id"
    t.bigint "administrator_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["administrator_id"], name: "index_notes_on_administrator_id"
    t.index ["department_id"], name: "index_notes_on_department_id"
    t.index ["institution_id"], name: "index_notes_on_institution_id"
    t.index ["institutional_unit_id"], name: "index_notes_on_institutional_unit_id"
  end

  add_foreign_key "administrative_assistants", "administrators"
  add_foreign_key "administrators", "departments"
  add_foreign_key "administrators", "institutional_units"
  add_foreign_key "administrators", "institutions"
  add_foreign_key "departments", "institutional_units"
  add_foreign_key "departments", "institutions"
  add_foreign_key "institutional_units", "institutions"
  add_foreign_key "notes", "administrators"
  add_foreign_key "notes", "departments"
  add_foreign_key "notes", "institutional_units"
  add_foreign_key "notes", "institutions"
end
