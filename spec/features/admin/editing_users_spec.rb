require 'rails_helper'

feature "EditingUser", :type => :feature do
  let!(:admin_user) { FactoryGirl.create(:admin_user) }
  let!(:user) { FactoryGirl.create(:user, email: "oldguy.example.com") }

  before do
    sign_in_as!(admin_user)
    visit '/'
    click_link "Admin"
    click_link "Users" 
    click_link user.email
    click_link "Edit User"
  end

  scenario "Updating a user's details" do
    fill_in "Email", with: "newguy@example.com"
    click_button "Update User"
    expect(page).to have_content("User has been updated.")
    expect(page).to have_content("newguy@example.com")
    expect(page).to_not have_content(user.email)
  end
end
