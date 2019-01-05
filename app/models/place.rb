class Place < ApplicationRecord
  has_many :photos

  validates :name, presence: true
  validates :place_code, presence: true, uniqueness: true
end
