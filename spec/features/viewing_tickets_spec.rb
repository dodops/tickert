require 'rails_helper'

feature "ViewingTickets", :type => :feature do
  before do
    textmate = FactoryGirl.create(:project, name: "TextMate", description: "some valid issue")
    scss = FactoryGirl.create(:project, name: "Vim", description: "best editor ever")

    FactoryGirl.create(:ticket,
                      project: textmate,
                      title: "Make it shiny",
                      description: "blablabla")
    visit '/'
  end

  scenario "viewing tickets for a given project" do
    click_link "TextMate"

    expect(page).to have_content("Make it shiny")
    expect(page).to_not have_content("blablabla")
  end
end
