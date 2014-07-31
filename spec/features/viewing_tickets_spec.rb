require 'rails_helper'

feature "ViewingTickets", :type => :feature do
  before do
    user = FactoryGirl.create(:user)
    textmate = FactoryGirl.create(:project, name: "TextMate", description: "some valid issue")
    scss = FactoryGirl.create(:project, name: "Vim", description: "best editor ever")

    FactoryGirl.create(:ticket,
                      project: textmate,
                      title: "Make it shiny",
                      description: "blablabla")

    define_permission!(user, "view", textmate)
    define_permission!(user, "view", scss)
    sign_in_as!(user)
    visit '/'
  end

  scenario "viewing tickets for a given project" do
    click_link "TextMate"

    expect(page).to have_content("Make it shiny")
    expect(page).to_not have_content("blablabla")
  end
end
