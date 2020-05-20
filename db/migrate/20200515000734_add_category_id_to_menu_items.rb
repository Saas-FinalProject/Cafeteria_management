class AddCategoryIdToMenuItems < ActiveRecord::Migration[6.0]
  def change
    add_column :menu_items, :category_id, :bigint
  end
end
