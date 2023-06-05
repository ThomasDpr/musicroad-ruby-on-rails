class City < ApplicationRecord

  has_many :chatrooms, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
