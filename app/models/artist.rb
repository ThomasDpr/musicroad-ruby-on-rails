class Artist < ApplicationRecord
  has_many :festivals_artists
  has_many :festivals, through: :festivals_artists

  validates :name, presence: true, uniqueness: true
end
