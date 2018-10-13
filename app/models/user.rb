class User < ApplicationRecord
  has_many :photos

  #attr_accessor :password
  has_secure_password

  validates_presence_of :username
  validates_uniqueness_of :username

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ?
               BCrypt::Engine::MIN_COST :
               BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

end
