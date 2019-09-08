class Post < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :user
  validates :content, presence: true, length: { maximum: 10 }
end
