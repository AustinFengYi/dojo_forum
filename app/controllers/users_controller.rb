class UsersController < ApplicationController

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "user info was successfully updated"
      redirect_to posts_user_path(@user)
    else
      flash[:alert] = "user info was failed to update"
      render :edit 
    end
  end 


  def posts
    @user = User.find(params[:id])
    @posts = @user.posts.where(status: true).order(created_at: :desc)
  end 

  def comments
    @user = User.find(params[:id])
    @comments = @user.replies.order(created_at: :desc)
  end

  def collects
    @user = User.find(params[:id])
    @collects = @user.favorites.order(created_at: :desc)
  end

  def drafts
    @user = User.find(params[:id])
    @posts = @user.posts.where(status: false).order(created_at: :desc)
  end

  def friends
    @user = User.find(params[:id])
    @friends = @user.all_friends
    @unconfirm_friends = @user.unconfirm_friends
    @request_friends = @user.request_friends
  end

  private

  def user_params
    params.require(:user).permit(:name, :avatar, :introduction)
  end

end

