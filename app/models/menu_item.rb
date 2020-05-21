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
    puts "name is #{name} active is#{active} menu.active is #{menu.active}"
    if active && menu.active
      return true
    else
      return false
    end
  end
end
