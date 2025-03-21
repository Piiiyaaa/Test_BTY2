class Post < ApplicationRecord
    belongs_to :user
    has_one :daily_question, dependent: :destroy
    accepts_nested_attributes_for :daily_question

    validates :title, presence: true, length: { maximum: 20 }
    validates :body, presence: true, length: { maximum: 400 }
    validates :learning_date, presence: true
end
