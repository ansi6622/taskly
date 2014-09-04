class AddAssignedToToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :assigned_to_id, :integer, :index => true
  end
end
