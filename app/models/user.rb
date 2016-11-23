class User < ApplicationRecord
  #attr_accessor :password
  has_secure_password

  validates_presence_of :username
  validates_uniqueness_of :username
end
