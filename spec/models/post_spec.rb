require 'rails_helper'

RSpec.describe Post, type: :model do
    describe 'バリデーションチェック' do
        it '設定したすべてのバリデーションが機能しているか' do
            post = build(:post, :with_image)
            expect(post).to be_valid
        end

        it 'タイトルがないときにバリデーションが機能してinvalidになるか' do
            post_without_title = build(:post, title:"")
            expect(post_without_title).to be_invalid
            expect(post_without_title.errors[:title]).not_to be_empty
        end

        it 'タイトルが20文字を超えるとinvalidになるか' do
            post_with_long_title = build(:post, title: "a" * 21)
            expect(post_with_long_title).to be_invalid
            expect(post_with_long_title.errors[:title]).not_to be_empty
        end

        it '本文がないときにバリデーションが機能してinvalidになるか' do
            post_without_body = build(:post, body:"")
            expect(post_without_body).to be_invalid
            expect(post_without_body.errors[:body]).not_to be_empty
        end

        it 'bodyが400文字を超えるとinvalidになるか' do
            post_with_long_body = build(:post, body: "a" * 401)
            expect(post_with_long_body).to be_invalid
            expect(post_with_long_body.errors[:body]).not_to be_empty
        end

        it '学習日がないときにバリデーションが機能してinvalidになるか' do
            post_without_learning_date = build(:post, learning_date:"")
            expect(post_without_learning_date).to be_invalid
            expect(post_without_learning_date.errors[:learning_date]).not_to be_empty
        end

        it '不正な形式の画像ファイルはinvalidになるか' do
            post = build(:post)
            file = StringIO.new("dummy text file")
            post.image.attach(io: file, filename: 'test.txt', content_type: 'text/plain')
            expect(post).to be_invalid
            expect(post.errors[:image]).not_to be_empty
        end

        it '1MBを超える画像ファイルはinvalidになるか' do
            post = build(:post)
            large_file = StringIO.new("0" * (1.megabyte + 1))
            post.image.attach(io: large_file, filename: 'large.jpg', content_type: 'image/jpeg')
            expect(post).to be_invalid
            expect(post.errors[:image]).not_to be_empty
          end

    end
end