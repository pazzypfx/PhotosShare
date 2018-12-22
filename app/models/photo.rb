class Photo < ApplicationRecord
  belongs_to :user
  belongs_to :variety
  delegate :product, to: :variety # eq to: has_one :product, through: :variety
  belongs_to :place

  mount_uploader :path, PhotoUploader

  validates :path, presence: true

  self.per_page = 8

  def product
    self.variety.product if variety.present?
  end

  def product=(val); end

  def self.find_all(product, variety, place)
    photos = Photo.all
    photos = product.photos if product.present?
    photos = photos.where(variety: variety) if variety.present?
    photos = photos.where(place: place) if place.present?
    photos
  end

  def self.filter_by_ages(lower, upper)
    photos = self
    photos = photos.where('age <= ?', upper) if upper.present?
    photos = photos.where('age >= ?', lower) if lower.present?
    photos
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
