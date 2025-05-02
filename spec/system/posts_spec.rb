require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  let(:user) { create(:user, email: 'test@example.com', password: 'password', password_confirmation: 'password') }


  before do
    sign_in(user)
  end

    # describe '投稿一覧' do
    #     it '投稿一覧ページが表示される' do
    #         visit posts_path
    #         expect(page).to have_content(I18n.t('posts.index.title'))
    #     end

    #     it '投稿が存在する場合、それらが表示される' do
    #         post = create(:post, user: user)
    #         visit posts_path
    #         expect(page).to have_content(post.title)
    #     end
    # end

    describe '新規投稿' do
        it '投稿を作成できる', js: true do
          visit new_post_path
          puts page.html  # HTMLを出力
          # 必須フィールドをすべて入力
          fill_in 'post_learning_date', with: Date.today
          fill_in 'post_title', with: 'Railsの学習'
          fill_in 'post_body', with: 'RSpecでのテスト方法を学びました'
          fill_in 'post_tag_names', with: 'Rails,テスト,RSpec'
         
          fill_in 'post_daily_question_attributes_body', with: "次のうち、正しいのはどれ？\nA) RSpecはRuby用のテストフレームワーク\nB) RSpecはPython用\nC) RSpecはJava用"
          fill_in 'post_daily_question_attributes_question_answer', with: 'A'

          
          expect {
            find('input[type="submit"]').click
            expect(page).to have_content('学びの振り返りを作成しました！'), wait: 10
          }.to change(Post, :count).by(1)
             .and change(DailyQuestion, :count).by(1)
             .and change(Tag, :count).by(3)
        end
    end
end
