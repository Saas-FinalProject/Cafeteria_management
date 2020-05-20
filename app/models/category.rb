class Category < ApplicationRecord
  has_many :menu_items, dependent: :delete_all
  validates :name, presence: true

  def self.displayable
    categories = Category.all.map { |category| [category.name, category.id] }
    categories.unshift(["Select Category", ""])
    return categories
  end

  def validate?
    if menu_items.count != 0
      return true
    else
      return false
    end
  end

  def self.displayableCategoryItems
    categories = Category.all
    categories = categories.select do |category|
      menu_items = category.menu_items
      menu_items = menu_items.select { |menu_item| menu_item.validate? }
      menu_items.count > 0
    end
    return categories
  end
end
