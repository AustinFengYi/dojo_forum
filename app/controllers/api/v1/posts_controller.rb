class Api::V1::PostsController < ApiController
  before_action :authenticate_user!, :except => [:index]

  def index
    @posts = Post.all
    render json: {
      data: @posts
    }
  end

  def show
    @post = Post.find_by(id: params[:id])
    if !@post
      render json: {
        message: "sorry ,can't find the post!",
        status: 400
      }
    else
      if current_user.admin? || current_user == @post.user || @post.authority == "All" || (@post.authority == "Friend" && @post.user.my_friend?(current_user))
        render json: {
          data: @post
        }
      else
        render json: {
          message: "you have no authority to view this post!"
        }
      end
    end
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.status = true
    if @post.save
      render json: {
        message: "post was created successfully!",
        result: @post
      }
    else
      render json: {
        errors: @post.errors
      }
    end
  end

  def update
    @post = Post.find_by(id: params[:id])
    if @post.update(post_params)
      render json: {
        message: "post was updated successfully!",
        result: @post
      }
    else
      render json: {
        errors: @post.errors
      }
    end 
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    render json: {
      message: "post was destroy successfully!"
    }
  end

  private

  def post_params
    params.permit(:title,:content,:image,:authority,:status,:user_id,category_ids:[])
  end
end