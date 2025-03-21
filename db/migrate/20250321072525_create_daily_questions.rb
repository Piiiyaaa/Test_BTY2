class CreateDailyQuestions < ActiveRecord::Migration[7.2]
  def change
    create_table :daily_questions do |t|
      t.text :body
      t.text :question_answer
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
