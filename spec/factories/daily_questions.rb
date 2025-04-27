FactoryBot.define do
    factory :daily_question do
      content { "今日の振り返り質問内容" }
      answer { "質問に対する回答" }
      association :post
    end
  end