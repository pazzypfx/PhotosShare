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

  def self.filter_by_ages(lower, upper)
    photos = self
    photos = photos.where('age <= ?', upper) unless upper.blank?
    photos = photos.where('age >= ?', lower) unless lower.blank?
    return photos
  end

  enum ages:
    {
      '3 months': 3,
      '6 months': 6,
      '9 months': 9,
      '12 months': 12,
      '15 months': 15,
      '18 months': 18,
    }
end
