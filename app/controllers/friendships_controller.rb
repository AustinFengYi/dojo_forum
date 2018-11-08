class FriendshipsController < ApplicationController
  def create
    @friendship = Friendship.create(user_id:current_user.id, friend_id: params[:friend_id])
    if @friendship.save
      flash[:notice]="Successfully send friend request"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert]=@friendship.errors.full_messages.to_sentence
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    #if current_user.friendships.empty? && current_user.inverse_friendships.empty?
      if 
        @friendship = Friendship.where(user_id:current_user.id, friend_id: params[:id],status:false).first
        #@friendship = current_user.unconfirm_friendships.where(friend_id: params[:id]).first
        @friendship.destroy
        flash[:alert]="已收回好友申請"
        redirect_back fallback_location: root_path
      
    elsif
        @friendship = current_user.inverse_friendships.where(user_id: params[:id],status:true).first||current_user.friendships.where(friend_id: params[:id],status:true).first
        #@friendship = Friendship.where(user_id:current_user.id, friend_id: params[:id],status:true).first
        #@friendship = current_user.inverse_friendships.where(user_id: params[:id]).first
        @friendship.destroy
        flash[:alert]="已刪除好友關係"
        redirect_back fallback_location: root_path
    end
    #end
  end

  def confirm
    @friendship = current_user.request_friendships.where(user_id: params[:format]).first
    @friendship.update(status: true)
    
    redirect_back fallback_location: root_path
  end

  def refuse
    @friendship = current_user.request_friendships.where(user_id: params[:format]).first
    @friendship.destroy

    redirect_back fallback_location: root_path
  end
end
