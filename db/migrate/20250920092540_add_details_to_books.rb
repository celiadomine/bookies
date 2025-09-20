class AddDetailsToBooks < ActiveRecord::Migration[8.0]
  def change
    add_column :books, :description, :text
    add_column :books, :published_date, :string
  end
end
