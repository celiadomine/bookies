require 'net/http'
require 'json'
require 'uri'

class GoogleBooksService
  def self.search_books(query)
    uri = URI("https://www.googleapis.com/books/v1/volumes?q=#{query}&maxResults=5")
    response = Net::HTTP.get(uri)  # Sends the request to Google Books API
    JSON.parse(response)  # Parse the response into JSON
  end
end
