require "rails_helper"

feature "Managing tasks" do
  before do
    @task_list = TaskList.create!(:name => "Work List")
  end

  scenario "added a task to a task list" do
    signin

    fill_in_description_and_due_date

    click_on "Create Task"

    expect(page).to have_content("Task was created successfully")
    expect(page).to have_content("This is the task description (3 days)")
  end

  scenario "user can view errors on a task list" do
    signin

    within("section", :text => "Work List") do
      click_on "Add Task"
    end

    click_on "Create Task"

    expect(page).to have_content("Your task could not be created")
  end

  scenario "user can delete a task" do
    Task.create!(:task_list => @task_list,
                 :due_date => Date.today + 1.days,
                 :description => "This is a task description")

    signin

    within("li", :text => "This is a task description") do
      click_on "Delete"
    end

    expect(page).to have_content("Task was deleted successfully")
    expect(page).to have_no_content("This is a task description")
  end

  scenario "user can complete a task and view completed tasks" do
    Task.create!(:task_list => @task_list,
                 :due_date => Date.today + 1.days,
                 :description => "This is a task description")
    Task.create!(:task_list => @task_list,
                 :due_date => Date.today + 1.days,
                 :description => "This is an already completed task",
                 :complete => true)
    signin

    within("li", :text => "This is a task description") do
      click_on "Complete"
    end

    expect(page).to have_content("Task was completed successfully")
    expect(page).to have_no_content("This is a task description")

    within("section", :text => "Work List") do
      click_on "Completed"
    end

    expect(page).to have_content("Work List - Completed")
    expect(page).to have_content("This is a task description")

    within("ul", :text => "This is an already completed task") do
      expect(page).to have_no_content("Completed")
    end
  end

  scenario "user can assign another user to the task" do
    pending
    User.create!(:name => "Jeff", :password => "a", :password_confirmation => "a", :email => "hello@blah.com")
    signin

    fill_in_description_and_due_date

    select "Jeff", :from => "User"

    click_on "Create Task"

    expect(page).to have_content("Task was created successfully")
    expect(page).to have_content("This is the task description (3 days) - Jeff")
  end

  def fill_in_description_and_due_date
    within("section", :text => "Work List") do
      click_on "Add Task"
    end

    expect(page).to have_content("Add a task")

    fill_in "Description", :with => "This is the task description"

    three_days = Date.today + 3.days
    select three_days.year, :from => "task[due_date(1i)]"
    select three_days.strftime("%B"), :from => "task[due_date(2i)]"
    select three_days.day, :from => "task[due_date(3i)]"
  end

end