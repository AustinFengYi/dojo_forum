class RepliesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @reply = @post.replies.create(reply_params)
    @reply.user = current_user

    if @reply.save
      @post.last_replied_at = @reply.created_at 
      @post.save
      
      flash[:notice] = "a comment is successfully created"
      redirect_to post_path(@post)
    else
      flash[:alert]="error,your content cannot be blank"
      redirect_to post_path(@post)
    end
  end

  def edit
    @post = Post.find(params[:post_id])
    @reply = @post.replies.find(params[:id])    
  end

  def update    
    @post = Post.find(params[:post_id])
    @reply = @post.replies.find(params[:id])    
    respond_to do |format|
      if @reply.update(reply_params)
        format.js
      else
        format.js
      end
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @reply = @post.replies.find(params[:id])    
    @reply.destroy
    respond_to do |format|
      #format.html{redirect_to post_url(@reply.post),notice:"comment was successfully deleted" }
      #format.json{head :no_content}  
      format.js
    end
  end


  private

  def reply_params
    params.require(:reply).permit(:content,:user_id,:post_id)
  end
 

end
