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

ActiveRecord::Schema.define(version: 2020_12_02_143703) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "cases", force: :cascade do |t|
    t.string "title", null: false
    t.string "case_reference", null: false
    t.text "contact_referent", default: "Matthieu Gilette", null: false
    t.string "street_number", null: false
    t.string "street_name", null: false
    t.string "city", null: false
    t.string "zipcode", limit: 5, null: false
    t.float "longitude"
    t.float "latitude"
    t.datetime "visit_date", null: false
    t.boolean "is_confirmed", default: false, null: false
    t.text "physical_description"
    t.text "geographical_description"
    t.text "potential_description"
    t.integer "old_surface", default: 0, null: false
    t.integer "old_rooms_count", default: 0, null: false
    t.string "old_type", null: false
    t.string "old_project", null: false
    t.integer "total_monthly_charges"
    t.integer "water_cost", default: 0
    t.integer "heater_cost", default: 0
    t.integer "electricity_cost", default: 0
    t.integer "union_charges_cost", default: 0
    t.integer "common_charges_cost", default: 0
    t.integer "total_buying_price"
    t.integer "seller_price", default: 0
    t.integer "estimated_negociation", default: 0
    t.integer "notary_charges", default: 0
    t.integer "property_taxes", default: 0
    t.integer "agency_charges", default: 0
    t.integer "renovation_union", default: 0
    t.integer "pno_insurance_cost"
    t.integer "pre_estimation_renovation_cost"
    t.integer "indicator_pre_estimation_renovation"
    t.integer "total_renovation_cost"
    t.integer "renovation_demolition_cost", default: 0
    t.integer "renovation_preparation_cost", default: 0
    t.integer "renovation_carpentry_cost", default: 0
    t.integer "renovation_plastering_cost", default: 0
    t.integer "renovation_electricity_cost", default: 0
    t.integer "renovation_plumbing_cost", default: 0
    t.integer "renovation_wall_ceiling_cost", default: 0
    t.integer "renovation_painting_cost", default: 0
    t.integer "renovation_flooring_cost", default: 0
    t.integer "renovation_kitchen_cost", default: 0
    t.integer "renovation_furniture_cost", default: 0
    t.integer "renovation_facade_cost", default: 0
    t.integer "renovation_security_cost", default: 0
    t.integer "renovation_masonry_cost", default: 0
    t.integer "renovation_covering_cost", default: 0
    t.integer "new_surface", default: 0
    t.integer "new_rooms_count", default: 0
    t.string "new_type"
    t.string "new_project"
    t.integer "total_rent_annual_estimations"
    t.integer "month_count", default: 0
    t.integer "total_rent_monthly"
    t.float "renta_brut"
    t.float "renta_net"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_cases_on_user_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.integer "rent_monthly"
    t.bigint "case_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["case_id"], name: "index_rooms_on_case_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "encrypted_password", null: false
    t.string "firstname", null: false
    t.string "lastname", null: false
    t.string "phone_number", null: false
    t.integer "role", default: 0
    t.boolean "approved", default: false, null: false
    t.string "profession", null: false
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

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "cases", "users"
  add_foreign_key "rooms", "cases"
end
