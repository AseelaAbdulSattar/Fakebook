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

  def like_post_and_comment
    @like = Like.find_by_likeable_id_and_likeable_type_and_user_id(params[:likeable_id], params[:likeable_type], current_user.id)
    if !@like.present?
      @like = current_user.likes.new(likeable_type: params[:likeable_type], likeable_id: params[:likeable_id])
      respond_to do |format|
        if @like.save
          @message = 'success'
          format.js
          format.html { redirect_to root_url, notice: 'like was successfully created.'}
        else
          @message = 'invalid'
          format.js
          format.html { render 'new', notice: 'Something went wrong.' }
        end
      end
    else
      respond_to do |format|
        if @like.destroy
          @message = 'success'
          format.js
          format.html { redirect_to root_url, notice: 'like was successfully destroyed.'}
        else
          @message = 'invalid'
          format.html { render 'new', notice: 'Something went wrong.' }
        end
      end
    end
  end

  # private
  # def like_params
  #   params.require(:like).permit(:user_id, :likeable_type, :likeable_id)
	# end
end
