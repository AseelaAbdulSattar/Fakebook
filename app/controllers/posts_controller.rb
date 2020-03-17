class PostsController < ApplicationController

  def new
    @post = Post.new
  end

	def create
		@post = current_user.posts.create(post_params)
		if @post.save
			flash[:success] = "Post Created successfully"
		else
			flash[:error] = "Something Wrong"
		end
		redirect_to root_url
	end

  def index
    @posts = current_user.posts.order(:created_at).page(params[:page])
  end

  def show
    post = Post.find_by_id(params[:id])
    check_post_presence(post)
  end

  def edit
    post = Post.find_by_id(params[:id])
    check_post_presence(post)
  end

  def update
    @post = Post.find(params[:id])
      if @post && @post.update!(post_params)
        flash[:success] = "Post successfully updated"
        redirect_to root_url
      else
        flash[:error] = "Something went wrong"
        render 'edit'
      end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post && @post.destroy
      flash[:success] = 'Post was successfully deleted.'
    else
      flash[:error] = 'Something went wrong'
    end
    redirect_to root_url
  end

  private
  def check_post_presence(post)
    if post.present?
			@post = post
		else
			flash[:error] = "Post with 'Id = #{params[:id]} is not available"
			redirect_to root_url
    end
  end

  def post_params
    params.require(:post).permit(:user_id, :text)
  end
end
