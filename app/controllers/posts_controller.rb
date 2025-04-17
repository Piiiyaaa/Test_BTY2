class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, only: %i[show edit update destroy]
  before_action :check_post_owner, only: %i[edit update destroy]

  def index
    @posts = Post.includes(:user, :tags)
    @tags = Tag.all.order(name: :asc) 
  end

  def new
    @post = Post.new
    @post.build_daily_question
  end

  def create
    @post = current_user.posts.build(post_params)
    tag_list = params[:post][:tag_names].split(',').map(&:strip) if params[:post][:tag_names].present?
    
    if @post.save && @post.save_with_tags(tag_names: tag_list || [])
      redirect_to posts_path, notice: t('.success')
    else
      flash.now[:alert] = t('.failure')
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @daily_question = @post.daily_question
  end

  def edit
    @daily_question = @post.daily_question
  end

  def update
    tag_list = params[:post][:tag_names].split(',').map(&:strip) if params[:post][:tag_names].present?
    
    if @post.update(post_params) && @post.save_with_tags(tag_names: tag_list || [])
      redirect_to post_path(@post), notice: t('.success')
    else
      flash.now[:alert] = t('posts.update.failure')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: t('posts.destroy.success'), status: :see_other
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :learning_date, :image,
                                 daily_question_attributes: %i[body question_answer])
  end

  def check_post_owner
    return if @post.user == current_user

    redirect_to posts_path, alert: t('errors.messages.unauthorized_edit_post')
  end
end