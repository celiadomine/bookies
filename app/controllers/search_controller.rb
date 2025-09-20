class SearchController < ApplicationController
  def index
    if params[:query].present?
      @books = GoogleBooksService.search_books(params[:query])['items']
    else
      @books = []
    end
  end
end