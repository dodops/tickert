require 'rails_helper'

feature "UserProfiles", :type => :feature do
  before do
    @user = FactoryGirl.create(:user, password: "some", password_confirmation: "some")
    visit user_path(@user)
  end

  scenario "viewing" do
    expect(page).to have_content(@user.name)
    expect(page).to have_content(@user.email)
  end
end

feature "Editing User", :type => :feature do
  scenario "updating a project" do
    user = FactoryGirl.create(:user, password: "s", password_confirmation: "s")

    visit user_path(user)
    click_link "Edit Profile"

    fill_in "Username", with: "new_username"
    click_button "Update Profile"

    expect(page).to have_content("Profile has been updated.")
  end
end
