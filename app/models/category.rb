class Category < ApplicationRecord
  has_many :menu_items, dependent: :delete_all
  validates :name, presence: true

  def self.displayable
    categories = Category.all.map { |category| [category.name, category.id] }
    categories.unshift(["Select Category", ""])
    return categories
  end

  def self.displayableCategoryItems
    #    menu_items = MenuItem.all
    #    menu_items = menu_items.select { |menu_item| menu_item.validate? }
    #    return menu_items
    displayableCategoryItems = {}
    categories = Category.all
    categories.each do |category|
      menu_items = category.menu_items
      menu_items = menu_items.select { |menu_item| menu_item.validate? }
      if menu_items.count > 0
        displayableCategoryItems[category.name] = menu_items
      end
    end
    return displayableCategoryItems
  end
end
