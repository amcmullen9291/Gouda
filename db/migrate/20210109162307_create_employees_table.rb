class CreateEmployeesTable < ActiveRecord::Migration[6.1]
  def change
    unless ActiveRecord::Base.connection.table_exists?('employees')
      create_table :employees do |t|
          t.string :badge_id
          t.string :first_name
          t.string :last_name
          t.string :email
          t.string :telephone
          t.string :location
          t.string :shift_id
          t.string :dept_id
          t.boolean :office, default: false
          t.string :password_digest
        end
      end
  end
end
