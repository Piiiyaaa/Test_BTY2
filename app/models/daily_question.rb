class DailyQuestion < ApplicationRecord
  belongs_to :post
  
  validates :body, presence: true, length: { maximum: 400 }
  validates :question_answer, presence: true, length: { maximum: 400 }
end