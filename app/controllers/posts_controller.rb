class PostsController < ApplicationController
  before_action :authenticate_user!
  
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
  
  private
  
  def post_params
    params.require(:post).permit(:title, :body)
  end
end