class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @users = User.all.order(:name).page(params[:page])
    @posts = Post.paginate(page: params[:page]).order("created_at ASC")
    respond_to do |format|
      format.csv { send_data @users.to_csv , filename: "users-#{Date.today}.csv" }
      format.html
      format.js
    end
  end

  def post_comments
    post = Post.find_by_id(params[:id])
    if post.present?
      @comments = post.comments
      render partial: "post_comments"
		else
			flash[:error] = "Post with 'Id = #{params[:id]} not available"
			redirect_to root_url
    end
  end

  def user_profile
    @user = User.find(params[:id])
    friendship = current_user.friend_with? @user
    @is_friend = "not_requested" and return unless friendship.present?

    if friendship.status
      @is_friend = true
    else
      @is_friend = false
    end
  end

  def search
    id = []
    parent_id = []
    @user_result = User.search(params[:q], load: false, fields: [:email], match: :word_start, misspellings: {edit_distance: 2})
    post_result = Post.search(params[:q], load: false, fields: [:text], misspellings: {edit_distance: 2}, aggs: [:user_id])
    comment_result = Comment.search(params[:q], load: false, fields: [:body], misspellings: {edit_distance: 2}, aggs: [:user_id, :post_id])
    if post_result.present?
      post_result.each do |r|
        id << r.id
      end
      @posts = Post.where(id: id).paginate(page: params[:page]).order("created_at ASC")
    end
    if comment_result.present?
      comment_result.each do |c|
        parent_id << c.commentable_id
      end
      @comments = Post.where(id: parent_id)
    end
  end

  def like_post_and_comment
    @like = Like.find_by_likeable_id_and_likeable_type_and_user_id(params[:likeable_id], params[:likeable_type], current_user.id)
    respond_to do |format|
      if !@like.present?
        @like = current_user.likes.new(like_params)
        if (@like.new_record? && @like.save) || (@like.persisted? && @like.save)
          @message = 'success'
          format.js
        else
          @message = 'invalid'
          format.js
        end
      else
        if @like.destroy
          @message = 'success'
          format.js
        else
          @message = 'invalid'
          format.js
        end
      end
    end
  end

  private
  def like_params
    params.require(:like).permit(:user_id, :likeable_type, :likeable_id)
	end
end
