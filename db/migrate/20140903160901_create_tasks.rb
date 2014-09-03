class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :description
      t.date :due_date
      t.references :task_list

      t.timestamps
    end
  end
end
