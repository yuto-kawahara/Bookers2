class AddCount1ToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :favorites_count, :integer, null: false, default: 0
  end
end
