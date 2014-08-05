class Ticket < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  has_many :assets
  validates :title, :description, presence: true
  accepts_nested_attributes_for :assets
end
