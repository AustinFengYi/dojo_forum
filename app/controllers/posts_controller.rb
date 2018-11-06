class PostsController < ApplicationController
  def index
    @posts = Post.order(created_at: :desc)
    @categories = Category.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create(post_params)
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
    @post = Post.find(params[:id])   
    @reply = @post.replies.new
    @replies = @post.replies.order(created_at: :asc)
  end 

  def edit
    @post = Post.find(params[:id])   
  end

  def update
    @post = Post.find(params[:id])
    if params[:commit] == "Save Draft"
      @post.status = false
    else
      @post.status = true
    end
    
    if @post.update(post_params)
      if @post.status == true    
        flash[:notice] = "Post was successfully updated"
      else
        flash[:notice] = "Post Draft was successfully updated"
      end
      redirect_to post_path(@post)    
    else
      flash[:notice] = "Failed to update"
      render :edit 
    end   
  end

  

  private


  def post_params
    params.require(:post).permit(:title,:content,:image,:authority,:user_id,:category_id)
  end
end
