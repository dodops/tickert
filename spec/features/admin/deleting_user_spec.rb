require 'rails_helper'

feature 'Deleting users', type: :feature do
  let!(:admin) { FactoryGirl.create(:admin_user) }
  let!(:user) { FactoryGirl.create(:user, email: "kakak@example.com") }

  before do
    sign_in_as!(admin)
    visit '/'
    click_link "Admin"
    click_link "Users"
  end

  scenario "deleting a user" do
    click_link user.email
    click_link "Delete user"

    expect(page).to have_content ("User has been deleted.")
  end
end
