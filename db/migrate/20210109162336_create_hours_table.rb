class CreateHoursTable < ActiveRecord::Migration[6.1]
  def change
    unless ActiveRecord::Base.connection.table_exists?('hours')
      create_table :hours do |t|
        t.string :badge_id
        t.string :dept_id
        t.string :last_name
        t.string :week_ending
        t.time :monday_in, default: 0
        t.time :monday_out, default: 0
        t.time :tuesday_in, default: 0
        t.time :tuesday_out, default: 0
        t.time :wednesday_in, default: 0
        t.time :wednesday_out, default: 0
        t.time :thursday_in, default: 0
        t.time :thursday_out, default: 0
        t.time :friday_in, default: 0
        t.time :friday_out, default: 0
        t.time :saturday_in, default: 0
        t.time :saturday_out, default: 0
        t.time :sunday_in, default: 0
        t.time :sunday_out, default: 0
        t.string :counter, default: 1
        t.integer :employee_id
      end
    end
  end
end
