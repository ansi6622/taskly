require "rails_helper"

describe Task do
  describe "#description_with_due_date" do
    def new_task(due_date)
      Task.new(:description => "desc",
               :due_date => due_date)
    end

    it "it displays days left in the future" do
      task = new_task(Date.today + 1.day)
      expect(task.description_with_due_date).to eq("desc (1 day)")
    end

    it "displays today when it's today" do
      task = new_task(Date.today)
        expect(task.description_with_due_date).to eq("desc (Today)")
    end

    it "displays 'Past' when it's in the past" do
      task = new_task(Date.today - 1.day)
      expect(task.description_with_due_date).to eq("desc (Past)")
    end
  end
end