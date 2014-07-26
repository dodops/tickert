class Project < ActiveRecord::Base
  has_many :tickets, dependent: :delete_all
  validates :name, :description, presence: true
end
