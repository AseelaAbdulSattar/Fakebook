class CommentsController < ApplicationController

	def create
		@comment = current_user.comments.new(comment_params)
		respond_to do |format|
			if @comment.save
				format.js
				format.html { redirect_to root_url, notice: 'Comment was successfully created.'}
			else
				format.html { render 'new', notice: 'Something went wrong.' }
			end
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
		respond_to do |format|
			if @comment.present? && @comment.destroy
				format.html { redirect_to root_url, notice: 'Comment was successfully deleted.' }
			else
				format.html { redirect_to root_url, error: 'Something went wrong.' }
			end
			format.json { head :no_content }
			format.js   { render :layout => false }
   end
  end

	private
  def comment_params
    params.require(:comment).permit(:user_id, :body, :commentable_type, :commentable_id)
	end

end
