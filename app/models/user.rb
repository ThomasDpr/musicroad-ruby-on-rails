require 'open-uri'

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :photo
  after_create :assign_default_photo

  def assign_default_photo
    # raise
    unless photo.attached?
      file = URI.open('https://res.cloudinary.com/dimfha9hq/image/upload/v1686824175/ckbegohguqopibywv5uq.svg')
      photo.attach(io: file, filename: 'avatar-login.png', content_type: 'image/svg')
    end
  end
end
