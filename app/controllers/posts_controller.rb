class PostsController < ApplicationController
  before_action :check_post_presence, only: [:show, :edit, :update, :destroy]

  def new
    @post = Post.new
  end

	def create
    @post = current_user.posts.new(post_params)
    respond_to do |format|
      if @post.save
        @message = 'success'
				format.js
				format.html { redirect_to posts_path, notice: 'Post was successfully created.'}
      else
        @message = 'invalid'
				format.html { render 'new', error: 'Something went wrong.' }
			end
		end
	end

  def index
    @posts = Post.where(user_id: params[:id]).order(:created_at).page(params[:page])
  end

  def show
  end

  def edit
  end

  def update
      if @post.update!(post_params)
        flash[:success] = "Post successfully updated"
        redirect_to root_url
      else
        flash[:error] = "Something went wrong"
        render 'edit'
      end
  end

  def post_comments
    @post = Post.find_by_id(params[:id])
    if @post.present?
      @comments = @post.comments
      render partial: "post_comments"
		else
			flash[:error] = "Post with 'Id = #{params[:id]} not available"
			redirect_to root_url
    end
  end

  def like
    @like = Like.where(like_params.merge({ user_id: current_user.id })).first
    respond_to do |format|
      if !@like.present?
        @like = current_user.likes.new(like_params)
        if (@like.new_record? && @like.save) || (@like.persisted? && @like.save)
          @message = 'success'
        else
          @message = 'invalid'
        end
      else
        if @like.destroy
          @message = 'success'
        else
          @message = 'invalid'
        end
      end
      format.js
    end
  end

  def destroy
    respond_to do |format|
      if @post.destroy
        format.html { redirect_to root_url, notice: 'Post was successfully deleted.' }

      else
        format.html { redirect_to root_url, notice: 'Something went wrong.' }
      end
      format.json { head :no_content }
      format.js   { render layout: false }
   end
  end

  private
  def check_post_presence
    post = Post.find_by_id(params[:id])
    if post.present?
			@post = post
		else
			flash[:error] = "Post with 'Id = #{params[:id]} is not available"
			redirect_to root_url
    end
  end

  def like_params
    params.require(:like).permit(:user_id, :likeable_type, :likeable_id)
  end

  def post_params
    params.require(:post).permit(:id, :user_id, :text, comments_attributes: [:user_id, :body, :commentable_type, :commentable_id, :_destroy])
  end
end
