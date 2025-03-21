class PostsController < ApplicationController
    before_action :authenticate_user!, except: [:index]

    def index
        @posts = Post.includes(:user)
    end

    def new
        @post = Post.new
        @post.build_daily_question
    end

    def create
        @post = current_user.posts.build(post_params)
        if @post.save
            redirect_to posts_path, notice: t('posts.create.success')
        else
            flash.now[:alert] = t('posts.create.failure')
            render :new, status: :unprocessable_entity
        end
    end

    private

    def post_params
        params.require(:post).permit(:title, :body, :learning_date,
        daily_question_attributes: [:body, :question_answer])
      end
end