require 'rails_helper'

feature "Signins", :type => :feature do
  scenario "Sign in." do 
    user = FactoryGirl.create(:user, password: "poder", password_confirmation: "poder")

    visit '/'
    click_link "Sign in"
    fill_in "Name", with: user.name
    fill_in "Password", with: user.password
    click_button "Sign in"

    expect(page).to have_content("Signed in successfully.")
  end
end
