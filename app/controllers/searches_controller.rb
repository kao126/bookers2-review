class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @range = params[:range]
    @search = params[:search]
    @word = params[:word]

    if @range == "User"
      @users = User.search_for(@search, @word)
    else
      @books = Book.search_for(@search, @word)
    end
  end
end
