class ProfilesController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_user, only: [:show]
  
  def show
    @user = params[:id] ? @user : current_user
    @posts = @user.posts.order(created_at: :desc)
  end
  
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to profile_path, notice: t('.profiles.update.success')
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  private
  
  def set_user
    @user = User.find(params[:id]) if params[:id]
  end
  
  def user_params
    params.require(:user).permit(:username, :bio)
  end
end