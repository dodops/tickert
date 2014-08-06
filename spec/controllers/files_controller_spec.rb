require 'rails_helper'

RSpec.describe FilesController, :type => :controller do
  let(:good_user) { FactoryGirl.create(:user) }
  let(:bad_user) { FactoryGirl.create(:user) }

  let(:project) { FactoryGirl.create(:project) }
  let(:ticket) { FactoryGirl.create(:ticket, project: project, user: good_user) }

  let(:path) { Rails.root + "spec/fixtures/speed.txt" }
  let(:asset) { ticket.assets.create(asset: File.open(path)) }

  before { good_user.permissions.create!(action: "view", thing: project) }

  context "users with access" do
    before { sign_in(good_user) }

    it "can access assets in a project" do
      get "show", id: asset.id
      expect(response.body).to eql(File.read(path))
    end
  end

  context "users without access" do
    before { sign_in(bad_user) }

    it "cannot access assets in a project" do
      get "show", id: asset.id
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eql("The asset you were looking for could not be found.")
    end
  end
end
