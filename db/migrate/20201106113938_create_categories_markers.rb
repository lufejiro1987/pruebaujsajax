class CreateCategoriesMarkers < ActiveRecord::Migration[6.0]
  def change

  # If you want to add an index for faster querying through this join:
  create_join_table :categories, :markers do |t|
    t.index :category_id
    t.index :marker_id
  end
  end
end
