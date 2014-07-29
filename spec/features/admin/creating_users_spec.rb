require 'rails_helper'

feature "CreatingUsers", :type => :feature do
  let!(:admin) { FactoryGirl.create(:admin_user) }

  before do
    sign_in_as!(admin)
    visit '/'
    click_link "Admin"
    click_link "Users"
    click_link "New User"
  end

  scenario "a new user" do
    fill_in "Email", with: "newbie@something.com"
    fill_in "Password", with: "password"
    click_button "Create User"
    expect(page).to have_content("User has been created.")
  end
end
