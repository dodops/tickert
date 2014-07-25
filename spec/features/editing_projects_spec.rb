require 'rails_helper'

feature "EditingProjects", :type => :feature do
  scenario "Updating a project" do
    FactoryGirl.create(:project, name: "TextMate", description: "easy way")


    visit '/'
    click_link "TextMate"
    click_link "Edit Project"

    fill_in "Name", with: "TextMate 2"
    fill_in "Description", with: "hard way"
    click_button "Update Project"

    expect(page).to have_content("Project has been updated.")
  end
end
