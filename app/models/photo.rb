class Photo < ApplicationRecord
  belongs_to :user
  belongs_to :variety
  delegate :product, :to => :variety # eq to: has_one :product, :through => :variety
  belongs_to :place

  validates_presence_of :path
end
