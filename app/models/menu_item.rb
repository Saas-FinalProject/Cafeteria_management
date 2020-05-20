class MenuItem < ApplicationRecord
  belongs_to :menu
  validates :name, presence: true
  validates :price, presence: true
  validates :category_id, presence: true

  def category
    id = category_id
    category = Category.find(id)
    category.name
  end

  def validate?
    menu = Menu.find(menu_id)
    return (active && menu.active)
  end
end
