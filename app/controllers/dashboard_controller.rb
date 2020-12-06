class DashboardController < ApplicationController
  def index
    @books = current_user.books.includes(:comments)
    @mycomments = Comment.where(user_id: current_user.id)
    @mywish = Trade.where(user_id: current_user.id)
    @trades = Trade.all
    @comments = Comment.where(params[:book_id])
  end

  private
  def comment_params
    params.require(:trade).permit(:user_id, :suggestion_book_id, :book_id)
  end
end
