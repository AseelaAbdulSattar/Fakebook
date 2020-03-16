class CommentsController < ApplicationController
	def create
		# byebug
		@comment = current_user.comments.new(body: params[:comment][:body], commentable_type: params[:comment][:commentable_type], commentable_id: params[:comment][:commentable_id])
		if @comment.save
			flash[:success] = "Comment successfully created"
			redirect_to :controller => 'home', :action => 'index'
		else
			flash[:error] = "Something went wrong"
			render 'new'
		end
	end

	def show
		@comment = Comment.find(params[:id])
	end


	def index
		@comments = Comment.where(commentable_id: params[:post_id])
	end



end
