class CommentsController < ApplicationController
	def create
		# byebug
		@comment = current_user.comments.new(body: params[:comment][:body], commentable_type:"Post", commentable_id: params[:comment][:commentable_id])
		if @comment.save
			flash[:success] = "Comment successfully created"
			redirect_to @comment
		else
			flash[:error] = "Something went wrong"
			render 'new'
		end
	end

	def index
		@comments = Comment.all
	end



end
