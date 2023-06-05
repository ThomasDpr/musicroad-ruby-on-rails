class Chatroom < ApplicationRecord
  belongs_to :city
  belongs_to :festival

  has_many :messages, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
