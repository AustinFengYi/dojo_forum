class CategoriesController < ApplicationController
  def show
    @categories = Category.all
    @category = Category.find(params[:id])
    #@posts = @category.posts.where(status:true).order(created_at: :desc).page(params[:page]).per(10)
    @q = @category.posts.where(status: true).ransack(params[:q])
    @posts = @q.result.order(id: :asc).page(params[:page]).per(20)
  end
end