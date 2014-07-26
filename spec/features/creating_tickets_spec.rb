require 'rails_helper'

feature "CreatingTickets", :type => :feature do
  before do
    FactoryGirl.create(:project, name: "Internet Explorer", description: 'awful')

    visit '/'
    click_link "Internet Explorer"
    click_link "New Ticket"
  end

  scenario 'creating a ticket' do

    fill_in "Title", with: "Non-stards compliance"
    fill_in "Description", with: "My pages are ugly"
    click_button "Create Ticket"

    expect(page).to have_content("Ticket has been created.")
  end

  scenario 'create a ticket with invalid attributes, must fail' do

    click_button 'Create Ticket'

    expect(page).to have_content("Ticket has not been created.")
    expect(page).to have_content("Title can't be blank")
  end
end
