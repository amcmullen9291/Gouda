class CreateHoursTable < ActiveRecord::Migration[6.1]
  def change
    unless ActiveRecord::Base.connection.table_exists?('hours')
      create_table :hours do |t|
        t.string :badge_id
        t.string :dept_id
        t.string :last_name
        t.string :week_ending
        t.datetime :monday_in, default: 0
        t.datetime :monday_out, default: 0
        t.datetime :tuesday_in, default: 0
        t.datetime :tuesday_out, default: 0
        t.datetime :wednesday_in, default: 0
        t.datetime :wednesday_out, default: 0
        t.datetime :thursday_in, default: 0
        t.datetime :thursday_out, default: 0
        t.datetime :friday_in, default: 0
        t.datetime :friday_out, default: 0
        t.datetime :saturday_in, default: 0
        t.datetime :saturday_out, default: 0
        t.datetime :sunday_in, default: 0
        t.datetime :sunday_out, default: 0
        t.string :counter, default: 1
        t.integer :employee_id
      end
    end
  end
end
