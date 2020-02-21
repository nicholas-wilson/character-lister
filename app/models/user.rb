class User < ActiveRecord::Base
  has_secure_password
  has_many :characters

  def slug
    self.username.gsub(/\s/, "-")
  end
end
