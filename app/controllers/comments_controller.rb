class CommentsController < ApplicationController
  before_action :authenticate_user!

	def index
	end

	def create
		@book = Book.find(params[:book_id])
    @comment = @book.comments.create(comment_params)
    @comment.user_id = current_user.id
    @comment.save

    respond_to do |format|
        format.js
    end
	end
  
  def edit
    @comment = Comment.find(params[:id])
    @book = Book.find(params[:book_id])
  end

  def update
    @comment = Comment.find(params[:id]) 
    if @comment.update_attributes(:accept => true)
      redirect_to dashboard_index_url
    else
      render 'edit'
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:title, :content)
  end

end
