class BooksController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update, :destroy, :new, :edit]

  def index
    @books = current_user.books.order(created_at: :desc)  # Get the books belonging to the current user
  end

  def show
    @book = Book.find(params[:id])
    @review = Review.new
  end

  def new
    google_books_id = params[:google_books_id]
    response = GoogleBooksService.get_book(google_books_id)
  
    if response && response['volumeInfo']
      book_details = response['volumeInfo']
      @book = Book.new(
        google_books_id: google_books_id,
        title: book_details['title'],
        authors: book_details['authors']&.join(', '),
        description: book_details['description'],
        published_date: book_details['publishedDate']
      )
    else
      # Handle the case where the API call fails or the ID is invalid
      redirect_to books_search_path, alert: "Book not found or an error occurred."
    end
  end
  

  def create
    @book = current_user.books.build(book_params)
    if @book.save
      redirect_to book_path(@book), notice: "Book added successfully!"
    else
      render :new
    end
  end
  

  def edit
    @book = Book.find(params[:id])
    # The view `app/views/books/edit.html.erb` will be rendered
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to @book, notice: "Book successfully updated!"
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path, notice: "Book successfully deleted."
  end
  

  private

  def book_params
    params.require(:book).permit(:title, :authors, :label, :description, :published_date, :google_books_id)
  end
end
