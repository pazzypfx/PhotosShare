class Product < ApplicationRecord
  has_many :varieties

  validates_presence_of :product_code
  validates_uniqueness_of :product_code
end
