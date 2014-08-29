class Task < ActiveRecord::Base
  include ActiveSupport::Inflector

  belongs_to :task_list
  validates :description, :presence => true
  validates :due_date, :presence => true

  def description_with_due_date
    "#{description} (#{due_date_description})"
  end

  private

  def due_date_description
    if due_date == today
      "Today"
    elsif due_date < today
      "Past"
    else
      "#{days_left} #{"day".pluralize(days_left)}"
    end
  end


  def days_left
    (due_date - today).to_i
  end

  def today
    Date.today
  end
end