class Photo < ApplicationRecord
  belongs_to :user
  belongs_to :variety
  delegate :product, to: :variety # eq to: has_one :product, through: :variety
  belongs_to :place

  mount_uploader :path, PhotoUploader

  validates_presence_of :path

  self.per_page = 8

  def product
    self.variety.product unless variety.blank?
  end

  def product=(val); end

  def self.find_all(product, variety, place)
    photos = Photo.all
    photos = product.photos unless product.blank?
    photos = photos.where(variety: variety) unless variety.blank?
    photos = photos.where(place: place) unless place.blank?
    return photos
  end
end
