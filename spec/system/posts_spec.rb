require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  let(:user) { create(:user, email: 'test@example.com', password: 'password', password_confirmation: 'password') }


  before do
    sign_in(user)
  end

    describe '投稿一覧' do
        it '投稿一覧ページが表示される' do
            visit posts_path
            expect(page).to have_content(I18n.t('posts.index.title'))
        end

        it '投稿が存在する場合、それらが表示される' do
            post = create(:post, user: user)
            visit posts_path
            expect(page).to have_content(post.title)
        end
    end

    describe '新規投稿' do
        it '投稿を作成できる', js: true do
          visit new_post_path
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

    describe '投稿詳細' do
        let!(:post) { create(:post, user: user, title: 'テスト投稿', body: 'テスト本文') }
        let!(:daily_question) { create(:daily_question, post: post, body: 'テスト問題', question_answer: 'テスト回答') }
        
        it '投稿の詳細が表示される' do
          visit post_path(post)
          
          expect(page).to have_content 'テスト投稿'
          expect(page).to have_content 'テスト本文'
          expect(page).to have_content 'テスト問題'
          expect(page).to have_content 'テスト回答'
        end
    end

    describe '投稿編集' do
        let!(:post) { create(:post, user: user, title: '編集前タイトル', body: '編集前本文') }
        let!(:daily_question) { create(:daily_question, post: post, body: '編集前問題', question_answer: '編集前回答') }
        
        it '投稿を編集できる' do
            visit edit_post_path(post)
            
            # 編集画面が正しく表示されていることを確認
            expect(page).to have_content(I18n.t('posts.edit.title'))
            
            # 元の内容が正しく表示されていることを確認
            expect(page).to have_field('post_title', with: '編集前タイトル')
            expect(page).to have_field('post_body', with: '編集前本文')
            expect(page).to have_field('post_daily_question_attributes_body', with: '編集前問題')
            expect(page).to have_field('post_daily_question_attributes_question_answer', with: '編集前回答')
            
            # 内容を編集
            fill_in 'post_title', with: '編集後タイトル'
            fill_in 'post_body', with: '編集後本文'
            fill_in 'post_daily_question_attributes_body', with: '編集後問題'
            fill_in 'post_daily_question_attributes_question_answer', with: '編集後回答'
            
            # 更新ボタンをクリック
            find('input[type="submit"]').click
            
            # 更新成功メッセージを確認
            expect(page).to have_content(I18n.t('posts.update.success'))
            
            # 変更が反映されていることを確認
            expect(post.reload.title).to eq '編集後タイトル'
            expect(post.body).to eq '編集後本文'
            expect(post.daily_question.body).to eq '編集後問題'
            expect(post.daily_question.question_answer).to eq '編集後回答'
            
            # 画面上でも変更が反映されていることを確認
            expect(page).to have_content('編集後タイトル')
            expect(page).to have_content('編集後本文')
        end

        it '不正な内容で編集するとエラーが表示される', js: true do
            visit edit_post_path(post)
            
            # タイトルを空にする（必須フィールド）
            fill_in 'post_title', with: ''
            
            # 更新ボタンをクリック
            find('input[type="submit"]').click
            
            # エラーメッセージが表示されることを確認
            expect(page).to have_content(I18n.t('errors.messages.blank'))
            
            # 元のデータが変更されていないことを確認
            expect(post.reload.title).to eq '編集前タイトル'
          end
        
          it '投稿を削除できる', js: true do
            visit post_path(post)
            expect(page).to have_content('編集前タイトル')
            expect {
              # 実際の削除ボタンを特定（実装によって異なる場合があります）
              find("form[action='#{post_path(post)}'] button[type='submit']").click

              page.accept_confirm
              
              # 削除成功メッセージを待つ
              expect(page).to have_content(I18n.t('posts.destroy.success')), wait: 10
            }.to change(Post, :count).by(-1)
             .and change(DailyQuestion, :count).by(-1)
            
            # # リダイレクト先が正しいことを確認（通常は一覧ページ）
            expect(page).to have_current_path(posts_path)
            
            # # 削除された投稿のタイトルが表示されていないことを確認
              expect(page).not_to have_content('編集前タイトル')
          end

    end   
end
