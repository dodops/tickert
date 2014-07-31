class User < ActiveRecord::Base
  has_secure_password
  has_many :permissions

  scope :admins, ->{ where(:admin => true) }

  def to_s
    "#{email} (#{admin? ? "Admin" : "User"})"
  end
end
