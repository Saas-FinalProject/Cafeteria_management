class RemoveQuantityFromMenuItems < ActiveRecord::Migration[6.0]
  def change
    remove_column :menu_items, :quantity
  end
end
