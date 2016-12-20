class Photo < ApplicationRecord
  belongs_to :user
  belongs_to :variety
  delegate :product, :to => :variety # eq to: has_one :product, :through => :variety
  belongs_to :place

  validates_presence_of :path

  def self.find_all(product, variety, place)
    photos = Photo.all
    photos = product.photos if !product.blank?
    photos = photos.where(variety: variety) if !variety.blank?
    photos = photos.where(place: place) if !place.blank?
    return photos
  end
end
