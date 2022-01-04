class Post < ApplicationRecord
  mount_uploader :image, ImageUploader
  
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :fav_users, through: :favorites, source: :user
  has_many :rates, dependent: :destroy
  has_many :rate_users, through: :rates, source: :user
  has_many :labels, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true
  validates :presence, presence: true
  validates :city, presence: true
  validates :town, presence: true
  validates :lat, presence: true
  validates :lng, presence: true
end
