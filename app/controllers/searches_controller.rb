class SearchesController < ApplicationController
  def search
    @range = params[:range]

    if @range == "User"
      @users = User.search(params[:search], params[:word])
    else
      @books = Book.search(params[:search], params[:word])
    end
  end
end
