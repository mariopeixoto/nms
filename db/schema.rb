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

ActiveRecord::Schema.define(version: 20161108005732) do

  create_table "condominia", force: true do |t|
    t.string   "name",                                   null: false
    t.float    "fine_pct",      limit: 24, default: 2.0, null: false
    t.float    "interest_pct",  limit: 24, default: 1.0, null: false
    t.integer  "indexation_id",                          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "condominia", ["indexation_id"], name: "condominia_indexation_id_fk", using: :btree

  create_table "debt_types", force: true do |t|
    t.string   "debt_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "debts", force: true do |t|
    t.integer  "unit_id",                                    null: false
    t.integer  "debt_type_id",                               null: false
    t.date     "due_date",                                   null: false
    t.string   "description"
    t.float    "original_amount", limit: 24,                 null: false
    t.boolean  "paid",                       default: false, null: false
    t.integer  "notice_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "debts", ["debt_type_id"], name: "debts_debt_type_id_fk", using: :btree
  add_index "debts", ["notice_id"], name: "debts_notice_id_fk", using: :btree
  add_index "debts", ["unit_id"], name: "debts_unit_id_fk", using: :btree

  create_table "indexation_values", id: false, force: true do |t|
    t.integer "indexation_id",            null: false
    t.date    "month",                    null: false
    t.float   "value",         limit: 24
  end

  create_table "indexations", force: true do |t|
    t.string   "name"
    t.integer  "tpa_id",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notices", force: true do |t|
    t.string   "generated_pdf_path"
    t.text     "address"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "owners", force: true do |t|
    t.string   "name"
    t.text     "address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "units", force: true do |t|
    t.string   "number"
    t.integer  "owner_id",       null: false
    t.integer  "condominium_id", null: false
    t.string   "building"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "units", ["condominium_id"], name: "units_condominium_id_fk", using: :btree
  add_index "units", ["owner_id"], name: "units_owner_id_fk", using: :btree

  add_foreign_key "condominia", "indexations", name: "condominia_indexation_id_fk"

  add_foreign_key "debts", "debt_types", name: "debts_debt_type_id_fk"
  add_foreign_key "debts", "notices", name: "debts_notice_id_fk"
  add_foreign_key "debts", "units", name: "debts_unit_id_fk"

  add_foreign_key "indexation_values", "indexations", name: "indexation_values_indexation_id_fk"

  add_foreign_key "units", "condominia", name: "units_condominium_id_fk"
  add_foreign_key "units", "owners", name: "units_owner_id_fk"

end
