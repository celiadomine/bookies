class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book
  before_action :set_post, only: [:destroy]
  before_action :authorize_post_access, only: [:destroy] # Only checking destroy here

  
  def new
    @book = Book.find(params[:book_id])
    @post = @book.posts.new
  end
  
  def create
    @book = Book.find(params[:book_id])
    @post = @book.posts.build(post_params)
    @post.user = current_user
    
        @post.post_type = 'general'

    if @post.save
      redirect_to book_path(@book), notice: "Post created successfully!"
    else
      render :new
    end
  end

  def destroy
    @post.destroy
    redirect_to book_path(@book), notice: "Post successfully deleted."
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :body)
  end

  def set_book
    @book = Book.find(params[:book_id])
  end

  def set_post
    @post = @book.posts.find(params[:id])
  end

  def authorize_post_access
    unless current_user == @post.user || current_user.admin?
      redirect_to book_path(@book), alert: "You are not authorized to delete this post."
    end
  end

end