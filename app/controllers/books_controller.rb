class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
# before_action :require_permisson, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show]
	
	def index
   		@books = Book.where('status')
	end

	def show
		@unapproved = Comment.where(accept: 0, user_id: current_user.id, book_id: params[:id])
  	end

	def new
		@book = Book.new
	end

	def edit
	end

	def create
 		@book = current_user.books.new(book_params)
 	  	if @book.save
      		redirect_to @book
		else
			render 'new'
		end
  	end 

	def update
  		@book = Book.find(params[:id])
 
		if @book.update(book_params)
			redirect_to @book
		else
			render 'edit'
		end
	end

	def destroy
		@book = Book.find(params[:id])
		@book.destroy
	
		redirect_to dashboard_index_url
  	end

	private

  	def book_params
    	params.require(:book).permit(:title, :author, :pagecount, :status, :tradeable)
 	end

	def set_book
		@book = Book.find(params[:id])
	end
end
