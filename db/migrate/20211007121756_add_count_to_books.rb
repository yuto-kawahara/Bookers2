class AddCountToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :book_comments_count, :integer, null: false, default: 0
    remove_column :books, :comments_count
  end
end
