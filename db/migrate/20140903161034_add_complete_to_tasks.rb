class AddCompleteToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :complete, :boolean, :null => false, :default => false
  end
end
