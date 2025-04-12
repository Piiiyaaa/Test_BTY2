class User < ApplicationRecord
  validates :username, presence: true, length: { maximum: 10 }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
  
  has_many :active_relationships, 
            class_name: 'Relationship',
            foreign_key: 'follower_id',
            dependent: :destroy
  has_many :passive_relationships, 
            class_name: "Relationship",
            foreign_key: "followed_id",
            dependent: :destroy
            
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  def like(post)
    liked_posts << post unless like?(post)
  end

  def unlike(post)
    liked_posts.delete(post)
  end

  def like?(post)
    liked_posts.include?(post)
  end
  
  def follow(other_user)
    return if self == other_user # 自分自身はフォローできない
    active_relationships.find_or_create_by(followed_id: other_user.id)
  end

  def unfollow(other_user)
    relationship = active_relationships.find_by(followed_id: other_user.id)
    relationship&.destroy 
  end

  # 現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end
end