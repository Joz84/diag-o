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

ActiveRecord::Schema.define(version: 20180118155112) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.bigint "question_id"
    t.bigint "option_choice_id"
    t.bigint "diagnostic_id"
    t.integer "numeric"
    t.string "string"
    t.boolean "boolean"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["diagnostic_id"], name: "index_answers_on_diagnostic_id"
    t.index ["option_choice_id"], name: "index_answers_on_option_choice_id"
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "bookings", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "housing_id"
    t.datetime "set_at"
    t.text "comment"
    t.datetime "confirmed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "diagnostic_id"
    t.index ["diagnostic_id"], name: "index_bookings_on_diagnostic_id"
    t.index ["housing_id"], name: "index_bookings_on_housing_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "diagnostics", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "plan"
  end

  create_table "housings", force: :cascade do |t|
    t.string "geoloc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
    t.integer "floor"
    t.integer "rooms"
    t.integer "surface"
    t.integer "construction_quality"
    t.integer "kitchen_quality"
    t.integer "bathroom_quality"
    t.integer "living_quality"
    t.integer "rooms_quality"
    t.boolean "parking_lot"
    t.boolean "basement"
    t.boolean "concierge"
    t.boolean "elevator"
    t.boolean "balcony"
    t.boolean "collective_heating"
    t.integer "valuation"
    t.boolean "only_valuation"
  end

  create_table "option_choices", force: :cascade do |t|
    t.string "name"
    t.bigint "option_group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["option_group_id"], name: "index_option_choices_on_option_group_id"
  end

  create_table "option_groups", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "points", force: :cascade do |t|
    t.bigint "zone_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "lng"
    t.string "lat"
    t.index ["zone_id"], name: "index_points_on_zone_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "name"
    t.bigint "section_id"
    t.string "information"
    t.bigint "option_group_id"
    t.integer "input_type"
    t.string "slug"
    t.bigint "unit_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["option_group_id"], name: "index_questions_on_option_group_id"
    t.index ["section_id"], name: "index_questions_on_section_id"
    t.index ["unit_id"], name: "index_questions_on_unit_id"
  end

  create_table "sections", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "towns", force: :cascade do |t|
    t.string "zipcode"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "units", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_housings", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "housing_id"
    t.integer "user_state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["housing_id"], name: "index_user_housings_on_housing_id"
    t.index ["user_id"], name: "index_user_housings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "phone"
    t.integer "role"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "zones", force: :cascade do |t|
    t.bigint "town_id"
    t.string "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "id_zone"
    t.float "latitude"
    t.float "longitude"
    t.index ["town_id"], name: "index_zones_on_town_id"
  end

  add_foreign_key "answers", "diagnostics"
  add_foreign_key "answers", "option_choices"
  add_foreign_key "answers", "questions"
  add_foreign_key "bookings", "diagnostics"
  add_foreign_key "bookings", "housings"
  add_foreign_key "bookings", "users"
  add_foreign_key "option_choices", "option_groups"
  add_foreign_key "points", "zones"
  add_foreign_key "questions", "option_groups"
  add_foreign_key "questions", "sections"
  add_foreign_key "questions", "units"
  add_foreign_key "user_housings", "housings"
  add_foreign_key "user_housings", "users"
  add_foreign_key "zones", "towns"
end
