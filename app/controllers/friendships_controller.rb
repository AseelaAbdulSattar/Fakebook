class FriendshipsController < ApplicationController
  before_action :destroy_friendship, only: [:destory, :unfriend]
  
  def destroy_friendship
    current_user.friendships.where(friend_id: params[:id]).first&.destroy!
  end
  
  #@is_unfriend = false
  def new
    @users = User.all_except(current_user).order(:name).page(params[:page])
  end

  def create
    @friendship = current_user.friendships.new(friend_id: params[:friend_id])
    if @friendship.save
      flash[:success] = "Request sent successfully"
    else
      flash[:error] = "Already Friends"
    end
    redirect_to new_friendship_path
  end

  def destroy
    redirect_to requests_sent_friendships_path
  end

  def unfriend
    redirect_to friendships_path
  end

  def accept_request
    @friend = Friendship.existing_friends(params[:id], current_user.id)
  end
  
  def update
    @friend = Friendship.find(params[:id])
    if @friend.update(friend_params)
      flash[:success] = "Request Accepted"
    else
      flash[:error] = "Something went wrong"
    end
    redirect_to friendships_path
  end

  def pending_friends
    @friends_req_pending = current_user.pending_friends
  end

  def requests_sent
    @friends_request_sent = current_user.sent_requests
  end

  def index
    @friends = current_user.my_friends
  end

  private
  def friend_params
    params.require(:friendship).permit(:user_id, :friend_id, :status)
  end
end
