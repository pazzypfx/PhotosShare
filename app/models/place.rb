class Place < ApplicationRecord
  has_many :photos

  validates_presence_of :name
end
