class PostsController < ApplicationController
  def index
    @posts = Post.order(created_at: :desc)
    @categories = Category.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if params[:commit] == "Save Draft"
      @post.status = false
    else
      @post.status = true
    end

    if @post.save  
      if @post.status == true    
        flash[:notice] = "Post was successfully created"
      else
        flash[:notice] = "Post Draft was successfully created"
      end
      redirect_to root_path
    else
      flash[:alert] = "Post was failed to create"
      render :new 
    end
  end

  def show
  @user = current_user
  @post = @user.posts.find(params[:id])   
  end 

  private


  def post_params
    params.require(:post).permit(:title,:content,:image,:authority,:user_id,:category_id)
  end
end
