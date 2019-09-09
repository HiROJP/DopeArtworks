class Post < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :user
  validates :content, presence: true, length: { maximum: 15 }
  validates :image, presence: true
  
  has_many :favorites, foreign_key: 'post_id', dependent: :destroy
  has_many :users, through: :favorites
end
