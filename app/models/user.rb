class User < ApplicationRecord
  validates :username, presence: true, length: { maximum: 10 }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
  has_many :followers,
           class_name: 'Relationship',
           foreign_key: 'follower_id',
           dependent: :destroy,
           inverse_of: :follower

  def like(post)
    liked_posts << post unless like?(post)
  end

  def unlike(post)
    liked_posts.delete(post)
  end

  def like?(post)
    liked_posts.include?(post)
  end
end
