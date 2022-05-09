class BooksController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]

  def index
    @books = Book.all.order(params[:sort])
    if params[:tag_id]
      @tag = Tag.find(params[:tag_id])
      @books = @tag.book.all.order(created_at: :desc)
    else
      @books = Book.all
    end
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    tag_list = params[:book][:name].split(",")
    if @book.save
      @book.save_tag(tag_list)
      redirect_to book_path(@book.id), notice: "You have created book successfully."
    else
      @books = Book.all
      render "index"
    end
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @book_new = Book.new
    @comment = BookComment.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :rate)
  end

  def ensure_correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    unless @user == current_user
      redirect_to books_path
    end
  end

end