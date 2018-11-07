class Admin::CategoriesController < ApplicationController
  before_action :authenticate_admin
  def index
    @categories = Category.order(created_at: :desc)
    if params[:id]
      @category = Category.find(params[:id])
    else
      @category = Category.new
    end
  end 

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "category was successfully created"
      redirect_to admin_categories_path
    else
      flash[:alert] ="category name cannot be blank"
      redirect_to admin_categories_path
    end
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to admin_categories_path
      flash[:notice] = "category was successfully updated"
    else
      flash[:alert] ="category name cannot be blank"
      redirect_to admin_categories_path
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    flash[:notice] = "category was successfully deleted"
    redirect_to admin_categories_path
  end

  def category_params
    params.require(:category).permit(:name)
  end 
end
