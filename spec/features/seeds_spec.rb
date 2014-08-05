require 'rails_helper'


feature "Seed data", type: :feature do
  scenario "The basis" do
    load Rails.root + "db/seeds.rb"
    user = User.where(email: "admin@example.com").first!
    project = Project.where(name: "Beta").first!
  end
end
