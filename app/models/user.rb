class User < ApplicationRecord
  #mount_uploader :image, ImageUploader
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 20 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  has_many :posts
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_relationship, source: :user
  
  has_many :favorites
  has_many :favposts, through: :favorites, source: :post
  
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  def like(post)
    favorites.find_or_create_by(post_id: post.id)
  end

  #お気に入り削除
  def unlike(post)
    favorite = favorites.find_by(post_id: post.id)
    favorite.destroy if favorite
  end

  #お気にり登録判定
  def  favpost?(post)
    self.favposts.include?(post)
  end
end