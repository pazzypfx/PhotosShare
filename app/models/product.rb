class Product < ApplicationRecord
  has_many :varieties
  has_many :photos, through: :varieties

  validates :product_code, presence: true, uniqueness: true
end
