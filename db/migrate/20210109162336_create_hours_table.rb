class CreateHoursTable < ActiveRecord::Migration[6.1]
  def change
    unless ActiveRecord::Base.connection.table_exists?('hours')
      create_table :hours do |t|
        t.string :badge_id
        t.string :dept_id
        t.string :last_name
        t.string :week_ending
        t.string :monday_in
        t.string :monday_out
        t.string :tuesday_in
        t.string :tuesday_out
        t.string :wednesday_in
        t.string :wednesday_out
        t.string :thursday_in
        t.string :thursday_out
        t.string :friday_in
        t.string :friday_out
        t.string :saturday_in
        t.string :saturday_out
        t.string :sunday_in
        t.string :sunday_out
        t.string :counter, default: 1
        t.integer :employee_id
      end
    end
  end
end
