class UsersGenre < ApplicationRecord
  belongs_to :genre
  belongs_to :user

  validates :genre, uniqueness: { scope: :user }
end
