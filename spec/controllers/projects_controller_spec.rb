require 'rails_helper'

RSpec.describe ProjectsController, :type => :controller do

  it "display an error for a missing project" do
    get :show, id: "not-here"
    expect(response).to redirect_to(projects_path)
    message = "The project you were looking for could not be found."
    expect(flash[:notice]).to eql(message)
  end


  it "renders the right template" do
    get :index
    expect(response).to render_template('index')
  end
end
