class Task < ActiveRecord::Base
  include ActiveSupport::Inflector

  belongs_to :task_list
  validates :description, :presence => true
  validates :due_date, :presence => true

  def description_with_due_date
    "#{description} (#{days_left} #{"day".pluralize(days_left)})"
  end

  private

  def days_left
    (due_date - Date.today).to_i
  end
end