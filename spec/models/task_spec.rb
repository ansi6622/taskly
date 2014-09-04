require "rails_helper"

describe Task do
  describe "#full_description" do
    def new_task(due_date)
      Task.new(:description => "desc",
               :due_date => due_date)
    end

    it "it displays days left in the future" do
      task = new_task(Date.today + 1.day)
      expect(task.full_description).to eq("desc (1 day)")
    end

    it "displays today when it's today" do
      task = new_task(Date.today)
        expect(task.full_description).to eq("desc (Today)")
    end

    it "displays 'Past' when it's in the past" do
      task = new_task(Date.today - 1.day)
      expect(task.full_description).to eq("desc (Past)")
    end

    it "displays the assigned user" do
      task = new_task(Date.today)
      task.assigned_to = User.new(:name => "Jeff Taggart")

      expect(task.full_description).to eq("desc (Today) - Jeff Taggart")
    end
  end
end