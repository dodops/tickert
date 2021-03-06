require 'rails_helper'

feature "HiddenLinks", :type => :feature do
  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:admin_user) }
  let(:project) { FactoryGirl.create(:project) }
  let(:ticket) { FactoryGirl.create(:ticket, project: project, user: user)}

  context "anonymous user" do
    scenario "cannont see the new project link" do
      visit '/'
      assert_no_link_for "New Project"
    end

    scenario "cannot see the edit project link" do
      visit project_path(project)
      assert_no_link_for "Edit Project"
    end

    scenario "cannot see the delete link" do
      visit project_path(project)
      assert_no_link_for "Delete Project"
    end
  end

  context "regular user" do
    before { sign_in_as!(user) }
    scenario "cannot see the new project link" do
      visit '/'
      assert_no_link_for "New Project"
    end

    scenario "cannot see the edit project link" do
      visit project_path(project)
      assert_no_link_for "Edit Project"
    end

    scenario "cannot see the delete link" do
      visit project_path(project)
      assert_no_link_for "Delete Project"
    end

    scenario "New ticket link is show to a user with permission" do
      define_permission!(user, "view", project)
      define_permission!(user, "create tickets", project)
      visit project_path(project)
      assert_link_for "New Ticket"
    end

    scenario "New ticket link is hidden from a user without permission" do
      define_permission!(user, "view", project)
      visit project_path(project)
      assert_no_link_for "New Ticket"
    end

    scenario "Edit ticket link is show to a user with permission" do
      ticket
      define_permission!(user, "view", project)
      define_permission!(user, "edit tickets", project)
      visit project_path(project)
      click_link ticket.title
      assert_link_for "Edit Ticket"
    end

    scenario "Edit ticket link is hidden from a user without permission" do
      ticket
      define_permission!(user, "view", project)
      visit project_path(project)
      click_link ticket.title
      assert_no_link_for "Edit Ticket"
    end
  end

  context "admin users" do
    before { sign_in_as!(admin) }
    
    scenario "can see the Nre Project link" do
      visit '/'
      assert_link_for "New Project"
    end

    scenario "can see the edit project link" do
      visit project_path(project)
      assert_link_for "Edit Project"
    end

    scenario "can see the delete project link" do
      visit project_path(project)
      assert_link_for "Delete Project"
    end

    scenario "New ticket link is shown to admins" do
      visit project_path(project)
      assert_link_for "New Ticket"
    end

    scenario "Edit ticket link is shown to admin" do
      ticket
      visit project_path(project)
      click_link ticket.title
      assert_link_for "Edit Ticket"
    end
  end
end
