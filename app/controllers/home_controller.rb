class HomeController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    @users = User.all.order(:name).page(params[:page])
    @posts = Post.all

    respond_to do |format|
      format.csv { send_data @users.to_csv , filename: "users-#{Date.today}.csv" }
      format.html
    end
  end
end
