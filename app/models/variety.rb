class Variety < ApplicationRecord
  belongs_to :product

  validates_presence_of :variety_code
  validates_uniqueness_of :variety_code

  validates_presence_of :product
end
