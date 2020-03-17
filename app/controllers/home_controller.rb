class HomeController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    @users = User.all.order(:name).page(params[:page])
    @posts = Post.paginate(page: params[:page]).order(:created_at)
    respond_to do |format|
      format.csv { send_data @users.to_csv , filename: "users-#{Date.today}.csv" }
      format.html
      format.js
    end
  end

  def get_comments
    post = Post.find_by_id(params[:id])
    if post.present?
      @comments = post.comments
      render partial: "get_comments"
		else
			flash[:error] = "Post with 'Id = #{params[:id]} not available"
			redirect_to root_url
    end
  end

end
