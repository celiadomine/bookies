class BooksController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update, :index]

  def index
    @books = current_user.books  # Get the books belonging to the current user
  end

  def show
    @book = Book.find(params[:id])
    @review = Review.new
  end

  def new
    @book = Book.new
  end

  def create
    @book = current_user.books.build(book_params)
    if @book.save
      redirect_to @book, notice: "Book added successfully!"
    else
      render :new
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :authors, :label)
  end
end
