class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.create(user_id: current_user.id, text: params[:post][:text])
		if @post.save
			flash[:success] = "Post Created successfully"
      redirect_to @post
		else
			flash[:error] = "Something Wrong"
      redirect_to action: :index
    end
  end

  # def add_comment
  #   @comment = Comment.new()
  # end

  def index
    @posts = Post.where(user_id: current_user.id).order(:user_id).page(params[:page])
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
      if @post.update!(post_params)
        flash[:success] = "Post successfully updated"
        redirect_to @post
      else
        flash[:error] = "Something went wrong"
        render 'edit'
      end
  end


  def destroy_post
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:success] = 'Post was successfully deleted.'
    else
      flash[:error] = 'Something went wrong'
    end
    redirect_to posts_url
  end

  private
  def post_params
    params.require(:post).permit(:user_id, :text)
  end

end
