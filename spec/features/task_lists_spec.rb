require 'rails_helper'

feature 'Task lists' do

  scenario 'User can view task lists' do
    TaskList.create!(name: "Work List")
    TaskList.create!(name: "Household Chores")

    signin

    expect(page).to have_content("Work List")
    expect(page).to have_content("Household Chores")
  end

  scenario "user can add a task list" do
    signin

    click_on "Add Task List"

    fill_in "Name", :with => "Some new task list"
    click_on "Create Task List"

    expect(page).to have_content("Task List was created successfully")
    expect(page).to have_content("Some new task list")
  end


  scenario "user can view errors on a task list" do
    signin

    click_on "Add Task List"

    click_on "Create Task List"

    expect(page).to have_content("Your task list could not be created")
  end

  scenario "user can edit a task list" do
    TaskList.create(:name => "Some task list")

    signin

    click_on "Edit"

    expect(find_field("Name").value).to eq("Some task list")

    fill_in "Name", :with => "A new name"
    click_on "Create Task List"

    expect(page).to have_content("Task List was updated successfully")
    expect(page).to have_content("A new name")
  end

  scenario "user viewing a single task list" do
    TaskList.create!(:name => "Some task list",
                     :tasks => [Task.new(:description => "Task 1",
                                         :due_date => Date.today),
                                Task.new(:description => "Task 2",
                                         :due_date => Date.today)])

    TaskList.create!(:name => "Some other task list")

    signin

    click_on "Some task list"

    expect(page).to have_content("Some task list")
    expect(page).to have_content("Task 1")
    expect(page).to have_content("Task 2")
  end
end

