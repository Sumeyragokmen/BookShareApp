class TradesController < ApplicationController
  def new 
    @book = Book.find(params[:book_id])
    @user = User.find_by_id(@book.user_id)
    @books = current_user.books.listed
  end

  def create
    @book = Book.find(params[:book_id])
    @trade = @book.trades.build(trade_params)
    if @trade.save
      redirect_to dashboard_index_url
    else
      render 'new'
    end
  end

  def edit
    @trade = Trade.find(params[:id])
    @trade_user = User.find(@trade.user_id)
    @trade_book = Book.find(@trade.suggestion_book_id)
  end

  def approve
    @trade = Trade.find(params[:id])
    @trade.update_attributes(:trade_status => 1)
    redirect_to dashboard_index_path
  end

  def deny
    @trade = Trade.find(params[:id])
    @trade.update_attributes(:trade_status => -1)
    redirect_to dashboard_index_path
  end

  private
  def trade_params
    params.require(:trade).merge(user_id: current_user.id).permit(:user_id, :suggestion_book_id)
  end
end
