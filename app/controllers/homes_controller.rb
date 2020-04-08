class HomesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @users = User.all.order(:name).page(params[:page])
    @posts = Post.paginate(page: params[:page]).order("created_at DESC")
    respond_to do |format|
      format.csv { send_data @users.to_csv , filename: "users-#{Date.today}.csv" }
      format.html
      format.js
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

  def report
    @report = current_user.reports.new(report_params)
    respond_to do |format|
      if @report.save
        @message = 'success'
      else
        @message = 'invalid'
      end
      format.js
    end
  end

  def search
    id = []
    parent_id = []
    @user_result = User.search(params[:q], load: false, fields: [:name], match: :word_start, misspellings: {edit_distance: 2})
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

  def report_params
    params.require(:report).permit(:user_id, :reportable_type, :reportable_id)
	end
end
