class Project < ActiveRecord::Base
  has_many :tickets
  validates :name, :description, presence: true
end
