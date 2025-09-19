class HomeController < ApplicationController
  def index
    @posts = Post.all
    @reviews = Review.all
  end
end
