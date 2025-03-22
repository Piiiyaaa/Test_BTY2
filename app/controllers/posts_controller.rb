class PostsController < ApplicationController
    before_action :authenticate_user!, except: [ :show ]

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
            redirect_to posts_path, notice: t('.success')
        else
            flash.now[:alert] = t('.failure')
            render :new, status: :unprocessable_entity
        end
    end

    def show
        @post = Post.find(params[:id])
        @daily_question = @post.daily_question
    end


    def edit
        @post = Post.find(params[:id])
        @daily_question = @post.daily_question
    end


    def update
        @post = Post.find(params[:id])
        if @post.update(post_params)
          redirect_to post_path(@post), notice: t('.success')
        else
          flash.now[:alert] = t('posts.update.failure')
          render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @post = Post.find(params[:id])
        @post.destroy
        redirect_to posts_path, notice: t('posts.destroy.success'), status: :see_other
    end

    private

    def post_params
        params.require(:post).permit(:title, :body, :learning_date, :image, 
        daily_question_attributes: [ :body, :question_answer ])
      end
end
