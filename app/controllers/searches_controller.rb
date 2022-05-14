class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @range = params[:range]
    @search = params[:search]
    @word = params[:word]

    if @range == "User"
      @records = User.search_for(@search, @word)
    elsif @range == "Book"
      @records = Book.search_for(@search, @word)
    else
      @records = Tag.search_for(@search, @word)
    end
  end
end
