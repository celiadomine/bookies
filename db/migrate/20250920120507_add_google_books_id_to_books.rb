class AddGoogleBooksIdToBooks < ActiveRecord::Migration[8.0]
  def change
    add_column :books, :google_books_id, :string
  end
end
