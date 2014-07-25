require 'rails_helper'

feature "ViewingProjects", :type => :feature do
  scenario "Listing all projects" do
    project = FactoryGirl.create(:project, name: "TextMate", description: "easy")

    visit '/'

    click_link 'TextMate'
    expect(page.current_url).to eql(project_url(project))
  end
end
