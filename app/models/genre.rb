class Genre < ApplicationRecord

  has_many :users_genres
  has_many :users, through: :users_genres

  validates :name, presence: true, uniqueness: true
end
