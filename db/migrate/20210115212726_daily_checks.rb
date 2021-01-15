class DailyChecks < ActiveRecord::Migration[6.1]
  def change
    add_column :hours, :mfin, :boolean, :default => false
    add_column :hours, :tuefin, :boolean, :default => false
    add_column :hours, :wedfin, :boolean, :default => false
    add_column :hours, :thrfin, :boolean, :default => false
    add_column :hours, :frifin, :boolean, :default => false
    add_column :hours, :satfin, :boolean, :default => false
    add_column :hours, :sunfin, :boolean, :default => false
  end
end
