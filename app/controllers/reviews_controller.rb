class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book
  before_action :set_review, only: [:destroy]
  before_action :authorize_review_access, only: [:destroy]

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

  def destroy
    @review.destroy
    redirect_to root_path, notice: "Review successfully deleted."
  end

  private

  def review_params
    params.require(:review).permit(:title, :body, :rating, :book_id)
  end

  def set_book
    @book = Book.find(params[:book_id])
  end

  # NEW: Loads the review (needs to be available for destroy)
  def set_review
    @review = @book.reviews.find(params[:id])
  end

  # NEW: Authorization check method
  def authorize_review_access
    unless current_user == @review.user || current_user.admin?
      redirect_to book_path(@book), alert: "You are not authorized to delete this review."
    end
  end
end
