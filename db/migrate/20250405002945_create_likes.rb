class CreateLikes < ActiveRecord::Migration[7.2]
  def change
    create_table :likes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end

    # ユーザーは各投稿に1回だけいいねできるように制約を追加
    add_index :likes, %i[user_id post_id], unique: true
  end
end
