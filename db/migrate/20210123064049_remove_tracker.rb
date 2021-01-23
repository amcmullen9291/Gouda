class RemoveTracker < ActiveRecord::Migration[6.1]
  def change
    remove_column :hours, :tracker, :integer
  end
end
