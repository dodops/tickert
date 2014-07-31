require 'rails_helper'

RSpec.describe ProjectsController, :type => :controller do
  let(:user) { FactoryGirl.create(:user) }

  before do
    sign_in(user)
  end

  context "standart users" do
  { new: :get,
    create: :post,
    edit: :get,
    update: :put,
    destroy: :delete }.each do |action, method|
      it "cannot access the #{action} action" do
        sign_in(user)
        send(method, action, :id => FactoryGirl.create(:project))
        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to eql("You must be an admin to do that.")
      end
    end
  end

  it "display an error for a missing project" do
    get :show, id: "not-here"
    expect(response).to redirect_to(projects_path)
    message = "The project you were looking for could not be found."
    expect(flash[:notice]).to eql(message)
  end

  it "cannot access the show action withou permission" do
    project = FactoryGirl.create(:project)
    get :show, id: project.id

    expect(response).to redirect_to(projects_path)
    expect(flash[:notice]).to eql("The project you were looking for could not be found.")
  end


  it "renders the right template" do
    get :index
    expect(response).to render_template('index')
  end
end
