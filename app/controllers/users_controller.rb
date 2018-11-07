class UsersController < ApplicationController

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
  end

  private

  def user_params
    params.require(:user).permit(:name, :avatar, :introduction)
  end

end

