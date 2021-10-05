class AddImpressionsCountToBook < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :impressions_count, :integer
  end
end
