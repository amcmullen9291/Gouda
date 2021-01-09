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

ActiveRecord::Schema.define(version: 2021_01_09_162350) do

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
    t.time "monday_in", default: "2000-01-01 00:00:00"
    t.time "monday_out", default: "2000-01-01 00:00:00"
    t.time "tuesday_in", default: "2000-01-01 00:00:00"
    t.time "tuesday_out", default: "2000-01-01 00:00:00"
    t.time "wednesday_in", default: "2000-01-01 00:00:00"
    t.time "wednesday_out", default: "2000-01-01 00:00:00"
    t.time "thursday_in", default: "2000-01-01 00:00:00"
    t.time "thursday_out", default: "2000-01-01 00:00:00"
    t.time "friday_in", default: "2000-01-01 00:00:00"
    t.time "friday_out", default: "2000-01-01 00:00:00"
    t.time "saturday_in", default: "2000-01-01 00:00:00"
    t.time "saturday_out", default: "2000-01-01 00:00:00"
    t.time "sunday_in", default: "2000-01-01 00:00:00"
    t.time "sunday_out", default: "2000-01-01 00:00:00"
    t.string "counter", default: "1"
    t.integer "employee_id"
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
