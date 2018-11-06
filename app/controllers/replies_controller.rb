class RepliesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @reply = @post.replies.create(reply_params)
    @reply.user = current_user

    if @reply.save
      flash[:notice] = "a comment is successfully created"
      redirect_to post_path(@post)
    else
      flash[:alert]="error,your content cannot be blank"
      redirect_to post_path(@post)
    end
  end


  private

  def reply_params
    params.require(:reply).permit(:content,:user_id,:post_id)
  end
 

end
