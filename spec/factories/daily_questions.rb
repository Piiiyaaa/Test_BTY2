FactoryBot.define do
    factory :daily_question do
      body { "これはテスト投稿の本文です。学習内容を記録するためのサンプルテキストです。" }
      question_answer { "これはテスト投稿の解答です。解答を記録するためのサンプルテキストです。" }
      association :post
    end
  end