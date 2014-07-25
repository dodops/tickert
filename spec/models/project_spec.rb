require 'rails_helper'

RSpec.describe Project, :type => :model do
  describe '.create' do
    it 'persists a user with valid attributes' do
      project = Project.create(name: "TextMate", description: "Smeels like")

      expect(project).to be_persisted
    end

    it 'does not persist if attributes are not valid' do
      project = Project.create

      expect(project).not_to be_persisted
      expect(project.errors[:name]).to include("can't be blank")
    end
  end
end
