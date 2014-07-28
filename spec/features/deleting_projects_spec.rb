require 'rails_helper'

feature "DeletingProjects", :type => :feature do
  before do
    sign_in_as!(FactoryGirl.create(:admin_user))
  end
  scenario 'deleting a project' do
    FactoryGirl.create(:project, name: 'Yadr', description: 'baby step')

    visit '/'
    click_link 'Yadr'
    click_link 'Delete Project'

    expect(page).to have_content('Project has been deleted.')

    visit '/'

    expect(page).to have_no_content('Yadr')
  end
end
