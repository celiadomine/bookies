class CreateBooks < ActiveRecord::Migration[8.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :authors
      t.string :isbn_10
      t.string :isbn_13
      t.string :cover_url

      t.timestamps
    end
  end
end
