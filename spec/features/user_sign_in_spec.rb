require "rails_helper"

feature "user sign in" do
  let!(:user) {create :user, email: "admin@framgia.com", password: "12345678"}

  scenario "valid" do
    visit new_user_session_path
    fill_in "Email", with: "admin@framgia.com"
    fill_in "Password", with: "12345678"
    click_on "Login"
    expect(page.current_path).to eq authenticated_root_path
  end

  scenario "invalid" do
    visit new_user_session_path
    fill_in "Email", with: ""
    fill_in "Password", with: ""
    click_on "Login"
    expect(page.current_path).to eq unauthenticated_root_path
  end
end
