require 'rails_helper'

feature "CreatingTickets", :type => :feature do
  before do
    project = FactoryGirl.create(:project)
    user = FactoryGirl.create(:user)
    define_permission!(user, "view", project)
    define_permission!(user, "create tickets", project)
    define_permission!(user, "tag", project)
    @email = user.email
    sign_in_as!(user)

    visit '/'
    click_link project.name
    click_link "New Ticket"

    # message = "You need to sign in or sign up before continuing."
    # expect(page).to have_content(message)

    # fill_in "Name", with: user.name
    # fill_in "Password", with: user.password
    # click_button "Sign in"

    # click_link pro.name
    # click_link "New Ticket"
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
