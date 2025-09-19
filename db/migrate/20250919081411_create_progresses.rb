class CreateProgresses < ActiveRecord::Migration[8.0]
  def change
    create_table :progresses do |t|
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.integer :status, null: false, default: 0
      t.integer :current_page
      t.integer :pages_total
      t.timestamps
    end
    add_index :progresses, [:user_id, :book_id], unique: true 
  end
end
