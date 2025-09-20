class ReviewsController < ApplicationController
  before_action :authenticate_user!


  def new
    @book = Book.find(params[:book_id])
    @review = @book.reviews.new
  end


  def create
    @book = Book.find(params[:book_id]) 
    
    @review = @book.reviews.build(review_params)
    @review.user = current_user
    
    if @review.save
      redirect_to book_path(@book), notice: "Review successfully created!"
    else
      # If save fails, re-render the 'new' template
      # The @book variable is now available for the form
      render :new
    end
  end

  def edit
    @review = current_user.reviews.find(params[:id])
  end

  def update
    @review = current_user.reviews.find(params[:id])
    if @review.update(review_params)
      redirect_to book_path(@review.book), notice: "Review erfolgreich aktualisiert!"
    else
      render :edit
    end
  end

  private

  def review_params
    params.require(:review).permit(:title, :body, :rating, :book_id)
  end
end
