require "rails_helper"

feature "user contribute question" do
  let!(:user) {create :user, email: "admin@framgia.com", password: "12345678"}
  let!(:question) {create :question, user: user}

  background do
    visit new_user_session_path
    fill_in "Email", with: "admin@framgia.com"
    fill_in "Password", with: "12345678"
    click_on "Login"
  end

  scenario "user create question" do
    visit new_question_path
    fill_in "Name", with: "Test Abc"
    fill_in "Content", with: "AAA"
    check "Is correct"
    click_on "Submit"
    expect(page).to have_content "Test Abc"
    expect(page).to have_content "Create successfully!"
  end

  scenario "user edit question" do
    visit questions_path
    click_on "Edit"
    fill_in "Name", with: "Edited"
    fill_in all("Content")[0], with: "AAA"
    click_on "Add Answer"
    fill_in all("Content")[-1], with: "New answer"
    check all("Is correct")[-1]
    click_on "Submit"
    expect(page).to have_content "Edited"
    expect(page).to have_content "Update successfully!"
  end
end
