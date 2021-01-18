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

ActiveRecord::Schema.define(version: 2021_01_18_050142) do

  create_table "employees", force: :cascade do |t|
    t.string "badge_id"
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "telephone"
    t.string "location"
    t.string "shift_id"
    t.string "dept_id"
    t.boolean "office", default: false
    t.string "password_digest"
  end

  create_table "hours", force: :cascade do |t|
    t.string "badge_id"
    t.string "dept_id"
    t.string "last_name"
    t.string "week_ending"
    t.string "monday_in"
    t.string "monday_out"
    t.string "tuesday_in"
    t.string "tuesday_out"
    t.string "wednesday_in"
    t.string "wednesday_out"
    t.string "thursday_in"
    t.string "thursday_out"
    t.string "friday_in"
    t.string "friday_out"
    t.string "saturday_in"
    t.string "saturday_out"
    t.string "sunday_in"
    t.string "sunday_out"
    t.string "counter", default: "1"
    t.integer "employee_id"
    t.integer "tracker", default: 1
  end

  create_table "weeks", force: :cascade do |t|
    t.string "badge_id"
    t.string "dept_id"
    t.string "week_ending"
    t.datetime "monday_in"
    t.datetime "monday_out"
    t.datetime "tuesday_in"
    t.datetime "tuesday_out"
    t.datetime "wednesday_in"
    t.datetime "wednesday_out"
    t.datetime "thursday_in"
    t.datetime "thursday_out"
    t.datetime "friday_in"
    t.datetime "friday_out"
    t.datetime "saturday_in"
    t.datetime "saturday_out"
    t.datetime "sunday_in"
    t.datetime "sunday_out"
    t.integer "employee_id"
  end

end
