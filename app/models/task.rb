class Task < ActiveRecord::Base
  include ActiveSupport::Inflector

  belongs_to :task_list
  belongs_to :assigned_to, :class => User
  validates :description, :presence => true
  validates :due_date, :presence => true

  def full_description
    "#{description} (#{due_date_description})#{assignee}"
  end

  private

  def assignee
    if assigned_to.present?
      " - #{assigned_to.name}"
    end
  end

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