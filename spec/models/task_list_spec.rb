require "rails_helper"

describe TaskList do
  describe "#incomplete_tasks" do
    it "returns them in order" do
      task_3 = Task.new(:description => "a",
                        :due_date => Date.today + 2.day)

      task_1 = Task.new(:description => "a",
                        :due_date => Date.today)

      task_2 = Task.new(:description => "a",
                        :due_date => Date.today + 1.day)

      task_list = TaskList.create!(:name => "h",
                                   :tasks => [task_2, task_1, task_3])

      task_list.reload
      expect(task_list.incomplete_tasks).to eq([task_1, task_2, task_3])
    end
  end
end