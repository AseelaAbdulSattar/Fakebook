class CommentsController < ApplicationController

	def create
		@comment = current_user.comments.new(comment_params)
		if @comment.save
			flash[:success] = "Comment successfully created"
			redirect_to root_url
		else
			flash[:error] = "Something went wrong"
			render 'new'
		end
	end

	def show
		comment = Comment.find_by_id(params[:id])
		if comment.present?
			@comment = comment
		else
			flash[:error] = "Comment with 'Id = #{params[:id]} not available"
			redirect_to root_url
    end
	end

	def destroy
    @comment = current_user.comments.find_by_id(params[:id])
    if @comment.present? && @comment.destroy
      flash[:success] = 'Comment was successfully deleted.'
    else
      flash[:error] = 'Something went wrong'
    end
    redirect_to root_url
  end

	private
  def comment_params
    params.require(:comment).permit(:user_id, :body, :commentable_type, :commentable_id)
	end

end
