class AddLabelToBooks < ActiveRecord::Migration[8.0]
  def change
    add_column :books, :label, :integer
  end
end
