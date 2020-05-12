class Order < ApplicationRecord
  has_many :order_items
  belongs_to :user

  def isValid?
    order = Order.find(id)
    if order.price > 0
      valid = true
    else
      valid = false
    end
  end
end
