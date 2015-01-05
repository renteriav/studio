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

ActiveRecord::Schema.define(version: 20140428035313) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: true do |t|
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.integer  "addressable_id"
    t.string   "addressable_type"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "attendances", force: true do |t|
    t.integer  "attendable_id"
    t.string   "attendable_type"
    t.integer  "teacher_id"
    t.date     "date"
    t.string   "status"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "customers", force: true do |t|
    t.string   "first"
    t.string   "last"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "detailed_sharings", force: true do |t|
    t.integer  "student_id"
    t.integer  "sharing_id"
    t.boolean  "attendance"
    t.boolean  "memory"
    t.boolean  "practice"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "extras", force: true do |t|
    t.integer  "student_id"
    t.integer  "teacher_id"
    t.integer  "instrument_id"
    t.integer  "room_id"
    t.date     "date"
    t.time     "start_time"
    t.time     "end_time"
    t.string   "category"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "instruments", force: true do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "instruments_teachers", id: false, force: true do |t|
    t.integer "instrument_id"
    t.integer "teacher_id"
  end

  create_table "lessons", force: true do |t|
    t.integer  "student_id"
    t.integer  "teacher_id"
    t.integer  "instrument_id"
    t.integer  "room_id"
    t.integer  "weekday"
    t.time     "start_time"
    t.time     "end_time"
    t.integer  "frequency"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "opro_auth_grants", force: true do |t|
    t.string   "code"
    t.string   "access_token"
    t.string   "refresh_token"
    t.text     "permissions"
    t.datetime "access_token_expires_at"
    t.integer  "user_id"
    t.integer  "application_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "opro_auth_grants", ["access_token"], name: "index_opro_auth_grants_on_access_token", unique: true, using: :btree
  add_index "opro_auth_grants", ["code"], name: "index_opro_auth_grants_on_code", unique: true, using: :btree
  add_index "opro_auth_grants", ["refresh_token"], name: "index_opro_auth_grants_on_refresh_token", unique: true, using: :btree

  create_table "opro_client_apps", force: true do |t|
    t.string   "name"
    t.string   "app_id"
    t.string   "app_secret"
    t.text     "permissions"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "opro_client_apps", ["app_id", "app_secret"], name: "index_opro_client_apps_on_app_id_and_app_secret", unique: true, using: :btree
  add_index "opro_client_apps", ["app_id"], name: "index_opro_client_apps_on_app_id", unique: true, using: :btree

  create_table "preferred_addresses", force: true do |t|
    t.integer  "address_id"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "rooms", force: true do |t|
    t.string   "name"
    t.string   "location"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "sharings", force: true do |t|
    t.date     "date"
    t.time     "start_time"
    t.time     "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sharings_students", id: false, force: true do |t|
    t.integer "sharing_id"
    t.integer "student_id"
  end

  create_table "sharings_teachers", id: false, force: true do |t|
    t.integer "sharing_id"
    t.integer "teacher_id"
  end

  create_table "students", force: true do |t|
    t.string   "first"
    t.string   "last"
    t.string   "cell"
    t.string   "email"
    t.date     "birthdate"
    t.integer  "grade"
    t.date     "schoolyear"
    t.integer  "customer_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "teachers", force: true do |t|
    t.string   "first"
    t.string   "last"
    t.string   "email"
    t.string   "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "telephones", force: true do |t|
    t.string   "number"
    t.string   "description"
    t.integer  "phoneable_id"
    t.string   "phoneable_type"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "loginable_type"
    t.integer  "loginable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
