class WelcomeController < ApplicationController
	def index
	   @books = Book.where('status': 1)
	end
end
