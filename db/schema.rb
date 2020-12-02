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

ActiveRecord::Schema.define(version: 2020_12_01_170646) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cases", force: :cascade do |t|
    t.string "title", null: false
    t.string "case_reference", default: "Matthieu Gilette", null: false
    t.text "contact_referent", null: false
    t.string "street_number", null: false
    t.string "street_name", null: false
    t.string "city", null: false
    t.string "zipcode", limit: 5, null: false
    t.string "longitude"
    t.string "latitude"
    t.datetime "visit_date", null: false
    t.boolean "is_confirmed", default: false, null: false
    t.text "physical_description"
    t.text "geographical_description"
    t.text "potential_description"
    t.integer "old_information_id"
    t.integer "total_monthly_charge"
    t.integer "water_cost"
    t.integer "electricity_cost"
    t.integer "union_charges_cost"
    t.integer "common_charges_cost"
    t.integer "total_buying_price"
    t.integer "seller_price"
    t.integer "estimated_negociation"
    t.integer "notary_charges"
    t.integer "property_taxes"
    t.integer "renovation_union"
    t.integer "renovation_id"
    t.integer "new_information_id"
    t.integer "pno_insurance_cost", null: false
    t.integer "rent_annual_estimations_total_cost"
    t.integer "month_count"
    t.integer "total_rent_monthly"
    t.float "renta_brut"
    t.float "renta_net"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "new_informations", force: :cascade do |t|
    t.integer "project_id"
    t.integer "type_id"
    t.integer "surface", null: false
    t.integer "rooms_count", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "old_informations", force: :cascade do |t|
    t.integer "project_id", null: false
    t.integer "type_id", null: false
    t.integer "surface", null: false
    t.integer "rooms_count", null: false
    t.bigint "cases_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cases_id"], name: "index_old_informations_on_cases_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "renovations", force: :cascade do |t|
    t.integer "total_renovation_cost"
    t.integer "demolition_cost"
    t.integer "preparation_cost"
    t.integer "carpentry_cost"
    t.integer "plastering_cost"
    t.integer "electricity_cost"
    t.integer "plumbing_cost"
    t.integer "wall_ceiling_cost"
    t.integer "painting_cost"
    t.integer "flooring_cost"
    t.integer "kitchen_cost"
    t.integer "furniture_cost"
    t.integer "facade_cost"
    t.integer "security_cost"
    t.integer "masonry_cost"
    t.integer "covering_cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rooms", force: :cascade do |t|
    t.integer "rent_monthly", null: false
    t.bigint "cases_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cases_id"], name: "index_rooms_on_cases_id"
  end

  create_table "types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "encrypted_password", null: false
    t.string "firstname"
    t.string "lastname"
    t.string "phone_number"
    t.integer "role", default: 0
    t.boolean "approved", default: false, null: false
    t.string "hunter"
    t.string "agency"
    t.string "notary"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "rooms", "cases", column: "cases_id"
end
