require 'rails_helper'

feature 'Task lists' do
  def signin
    create_user email: "user@example.com"

    visit signin_path

    click_on "Login"

    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"

    click_on "Login"
  end

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

end