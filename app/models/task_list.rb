class TaskList < ActiveRecord::Base
  has_many :tasks

  validates :name, :presence => true

  def incomplete_tasks
    tasks.where(:complete => false)
  end
end
