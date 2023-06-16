# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_06_16_150801) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "awards", force: :cascade do |t|
    t.string "title", null: false
    t.string "awardable_type"
    t.integer "awardable_id"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_awards_on_user_id"
  end

  create_table "recoveries", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.date "start_date", null: false
    t.date "target_date", null: false
    t.jsonb "report_dates", default: [], null: false
    t.integer "current_record", default: 0, null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "max_record", default: 0, null: false
    t.boolean "bookmarked", default: false, null: false
    t.boolean "completed", default: false, null: false
    t.integer "target_days", null: false
    t.index ["user_id"], name: "index_recoveries_on_user_id"
  end

  create_table "routines", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.jsonb "days", null: false
    t.integer "target_days", null: false
    t.integer "current_record", default: 0, null: false
    t.integer "max_record", default: 0, null: false
    t.boolean "completed", default: false, null: false
    t.boolean "bookmarked", default: false, null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_routines_on_user_id"
  end

  create_table "stoppers", force: :cascade do |t|
    t.datetime "datetime", null: false
    t.text "reason", null: false
    t.bigint "recovery_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "mood", null: false
    t.index ["recovery_id"], name: "index_stoppers_on_recovery_id"
  end

  create_table "thoughts", force: :cascade do |t|
    t.text "message", null: false
    t.integer "mood", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "bookmarked", default: false, null: false
    t.index ["user_id"], name: "index_thoughts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "username", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "awards", "users"
  add_foreign_key "recoveries", "users"
  add_foreign_key "routines", "users"
  add_foreign_key "stoppers", "recoveries"
  add_foreign_key "thoughts", "users"
end
