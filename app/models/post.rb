class Post < ApplicationRecord
  belongs_to :user
  has_one :daily_question, dependent: :destroy
  has_one_attached :image
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :taggings, dependent: :destroy  # 追加
  has_many :tags, through: :taggings       # 追加

  accepts_nested_attributes_for :daily_question

  validates :title, presence: true, length: { maximum: 20 }
  validates :body, presence: true, length: { maximum: 400 }
  validates :learning_date, presence: true
  validate :image_type_validation
  validate :image_size

  scope :with_tag, ->(tag_name) { joins(:tags).where(tags: { name: tag_name }) }

  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end

  def save_with_tags(tag_names:)
    ActiveRecord::Base.transaction do
      self.tags = tag_names.map { |name| Tag.find_or_initialize_by(name: name.strip) }
      save!
    end
    true
  rescue StandardError
    false
  end

  def tag_names
    tags.map(&:name).join(',')
  end

  private

  def image_type_validation
    return unless image.attached? && !image.content_type.in?(%w[image/jpeg image/png image])

    errors.add(:image, 'はJPEG、PNGでアップロードしてください')
  end

  def image_size
    return unless image.attached? && image.blob.byte_size > 1.megabytes

    errors.add(:image, '：1MB以下のファイルをアップロードしてください')
  end
end
