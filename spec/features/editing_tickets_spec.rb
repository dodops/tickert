require 'rails_helper'

feature "EditingTickets", :type => :feature do
  let!(:project) { FactoryGirl.create(:project) }
  let!(:user) { FactoryGirl.create(:user, password: "kkkk", password_confirmation: "kkkk") }
  let!(:ticket) do
    ticket = FactoryGirl.create(:ticket, project: project, title: "perfom" )
    ticket.update(user: user)
    ticket
  end

  before do
    define_permission!(user, "view", project)
    define_permission!(user, "edit tickets", project)
    sign_in_as!(user)
    visit '/'
    click_link project.name
    click_link ticket.title
    click_link "Edit Ticket"
  end

  scenario "Updating a ticket" do
    fill_in "Title", with: "Make it really shiny!"
    click_button "Update Ticket"

    expect(page).to have_content("Ticket has been updated.")
    expect(page).to_not have_content(ticket.title)
  end

  scenario "Updating a ticket with invalid attributes" do
    fill_in "Title", with: ""
    click_button "Update Ticket"

    expect(page).to have_content("Ticket has not been updated.")
  end
end
