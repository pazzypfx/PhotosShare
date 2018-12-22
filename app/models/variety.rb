class Variety < ApplicationRecord
  belongs_to :product
  has_many :photos

  validates :variety_code, presence: true, uniqueness: true
  validates :product, presence: true
end
