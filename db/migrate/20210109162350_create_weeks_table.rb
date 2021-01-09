class CreateWeeksTable < ActiveRecord::Migration[6.1]
  def change
    unless ActiveRecord::Base.connection.table_exists?('weeks')
      create_table :weeks do |t|
        t.string :badge_id
        t.string :dept_id
        t.string :week_ending
        t.datetime :monday_in
        t.datetime :monday_out
        t.datetime :tuesday_in
        t.datetime :tuesday_out
        t.datetime :wednesday_in
        t.datetime :wednesday_out
        t.datetime :thursday_in
        t.datetime :thursday_out
        t.datetime :friday_in
        t.datetime :friday_out
        t.datetime :saturday_in
        t.datetime :saturday_out
        t.datetime :sunday_in
        t.datetime :sunday_out
        t.integer :employee_id
      end
    end
  end
end
