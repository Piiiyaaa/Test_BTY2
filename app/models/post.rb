class Post < ApplicationRecord
    validates :title, presence: true, length: { maximum: 20 }
    validates :body, presence: true, length: { maximum: 400 }
    validates :learning_date, presence: true
  
    belongs_to :user
end