class Festival < ApplicationRecord
  has_many :festivals_artists
  has_many :artists, through: :festivals_artists
  has_many :favorites, dependent: :destroy
  has_one_attached :photo

  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  validates :name, presence: true, uniqueness: true
end
