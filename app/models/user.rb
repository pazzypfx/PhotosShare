class User < ApplicationRecord
  has_many :photos

  # attr_accessor :password
  has_secure_password

  validates :username, presence: true, uniqueness: true
  validates :role, presence: true

  # Returns the hash digest of the given string.
  def self.digest(string)
    cost =
      if ActiveModel::SecurePassword.min_cost
        BCrypt::Engine::MIN_COST
      else
        BCrypt::Engine.cost
      end
    BCrypt::Password.create(string, cost: cost)
  end

  enum role: %i[admin manager agent]
end
