require 'net/http'
require 'json'
require 'uri'

class GoogleBooksService
  def self.search_books(query)
    uri = URI("https://www.googleapis.com/books/v1/volumes?q=#{query}&maxResults=20")
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end

  def self.get_book(google_books_id)
    uri = URI("https://www.googleapis.com/books/v1/volumes/#{google_books_id}")
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end
end