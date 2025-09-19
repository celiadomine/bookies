class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def new
    @review = Review.new
  end

  def create
    @review = current_user.reviews.build(review_params)
    if @review.save
      redirect_to book_path(@review.book), notice: "Review erfolgreich erstellt!"
    else
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
