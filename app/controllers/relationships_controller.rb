class RelationshipsController < ApplicationController
    before_action :authenticate_user!
  
    def create
      @user = User.find(params[:followed_id])
      current_user.follow(@user)
      redirect_to user_profile_path(@user) 
    end
  
    def destroy
        @user = User.find(params[:followed_id])
        current_user.unfollow(@user)
        redirect_to user_profile_path(@user)
    end
  end