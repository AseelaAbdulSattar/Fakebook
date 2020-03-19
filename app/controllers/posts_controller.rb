class PostsController < ApplicationController
  def new
    @post = Post.new
  end

	def create
    @post = current_user.posts.new(post_params)
    respond_to do |format|
			if @post.save
				format.js
				format.html { redirect_to posts_path, notice: 'Post was successfully created.'}
			else
				format.html { render 'new', notice: 'Something went wrong.' }
			end
		end
	end

  def index
    @posts = current_user.posts.order(:created_at).page(params[:page])
  end

  def show
    post = Post.find_by_id(params[:id])
    check_post_presence(post) # before_actions
  end

  def edit
    post = Post.find_by_id(params[:id])
    check_post_presence(post)
    # before_actions
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

    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :no_content }
      format.js   { render :layout => false }
   end
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
    params.require(:post).permit(:id, :user_id, :text, comments_attributes: [:user_id, :body, :commentable_type, :commentable_id, :_destroy])
  end
end
