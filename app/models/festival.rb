class Festival < ApplicationRecord
  has_many :festivals_artists
  has_many :artists, through: :festivals_artists
  has_many :favorites, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
