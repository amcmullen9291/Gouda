class DeleteDailyCheck < ActiveRecord::Migration[6.1]
  def change
    remove_column :hours, :mfin, :boolean, :default => false
    remove_column :hours, :tuefin, :boolean, :default => false
    remove_column :hours, :wedfin, :boolean, :default => false
    remove_column :hours, :thrfin, :boolean, :default => false
    remove_column :hours, :frifin, :boolean, :default => false
    remove_column :hours, :satfin, :boolean, :default => false
    remove_column :hours, :sunfin, :boolean, :default => false

  end
end
