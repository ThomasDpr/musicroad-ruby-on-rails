class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :festival

  validates :user, uniqueness: { scope: :festival } # A user can favorite a festival only once
end
