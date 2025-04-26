require 'rails_helper'

RSpec.describe User, type: :model do
    describe 'バリデーションチェック' do
        it '設定したすべてのバリデーションが機能しているか' do
            user = build(:user)
            expect(user).to be_valid
        end

        it 'ユーザーネームがないときにバリデーションが機能してinvalidになるか' do
            user_without_username = build(:user, username:"")
            expect(user_without_username).to be_invalid
            expect(user_without_username.errors[:username]).not_to be_empty
        end

        it 'ユーザーネームが10文字を超えるとinvalidになるか' do
            user_with_long_name = build(:user, username: "a" * 11)
            expect(user_with_long_name).to be_invalid
            expect(user_with_long_name.errors[:username]).not_to be_empty
        end

        it 'メールアドレスが空欄だとinvalidになるか' do
            user_without_email = build(:user, email:"")
            expect(user_without_email).to be_invalid
            expect(user_without_email.errors[:email]).not_to be_empty
        end

        it 'メールアドレスが重複しているとinvalidになるか' do
            user1 = create(:user)
            user2 = build(:user, email: user1.email)
            expect(user2).to be_invalid
            expect(user2.errors[:email]).not_to be_empty
        end
    end

    describe 'バリデーションチェック' do
        it do

        end

end
