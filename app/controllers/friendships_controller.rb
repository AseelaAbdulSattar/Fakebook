class FriendshipsController < ApplicationController
  def new
    @users = User.all_except(current_user)
  end

  def create
    user = current_user
      @friend = Friendship.create(user_id: user.id, friend_id: params[:friend_id])
      if @friend.save
        flash[:success] = "Request sent successfully"
        redirect_to new_friendship_path
      else
        flash[:error] = "Already Friends"
        redirect_to new_friendship_path
      end
  end

  def show
    @friend = Friendship.find(params[:id])
  end

  def edit
    user = current_user
    @friend = Friendship.find_by_user_id_and_friend_id(params[:id], user.id)
  end

  def destroy
    user = current_user
    @friend = Friendship.find_by_user_id_and_friend_id(user.id, params[:id])
    @friend.destroy

    redirect_to friendships_path
  end
  
  def update
      @friend = Friendship.find(params[:id])
      flash[:error] = @friend
      if @friend.update(friend_params)
        flash[:success] = "Request Accepted"
        redirect_to friendships_path
      else
        flash[:error] = "Something went wrong"
        render "edit"
      end
  end

  def index
    user = current_user
    @friends = User.where(id: Friendship.where(user_id: user.id, status: true).pluck(:friend_id))
    @friends_request_sent = User.where(id: Friendship.where(user_id: user.id, status: nil).pluck(:friend_id))
    @friends_req_pending = User.where(id: Friendship.where(friend_id: user.id, status: nil).pluck(:user_id))
  end

  private
  def friend_params
    params.require(:friendship).permit(:user_id, :friend_id, :status)
  end
end
