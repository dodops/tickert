require 'rails_helper'

RSpec.describe User, :type => :model do
  describe ".create" do

    context "with a invalid attribute" do
      it {
        user = User.new(name: "Douglas")

        user.save
        expect(user).to_not be_valid

        user.password = "password"
        user.password_confirmation = ""
        user.save
        expect(user).to_not be_valid
      }
    end

    context "with valid attributes" do
      it { 
        user = User.create(name: "Douglas", password: "hunter", password_confirmation: "hunter")
        user.save

        expect(user).to be_valid
      }
    end
  end

  describe "#authentication" do
    let(:user) { User.create(name: "Steve", password: "hunter2", password_confirmation: "hunter2")}

    context "with a correct password" do
      it { expect(user.authenticate("hunter2")).to be }
    end

    context "with an incorrect password" do
      it { expect(user.authenticate("hunter")).to_not be }
    end
  end
end
