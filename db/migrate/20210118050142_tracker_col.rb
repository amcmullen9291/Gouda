class TrackerCol < ActiveRecord::Migration[6.1]
  def change
    add_column :hours, :tracker, :integer, :default => 1
  end
end
