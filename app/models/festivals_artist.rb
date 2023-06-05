class FestivalsArtist < ApplicationRecord
  belongs_to :artist
  belongs_to :festival

  validates :artist, uniqueness: { scope: :festival }
end
