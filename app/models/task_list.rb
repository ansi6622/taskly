class TaskList < ActiveRecord::Base
  has_many :tasks

  validates :name, :presence => true

  def incomplete_tasks
    tasks.where(:complete => false).order(:due_date)
  end

  def completed_tasks
    tasks.where(:complete => true)
  end
end
