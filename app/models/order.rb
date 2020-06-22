class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  belongs_to :user

  def isValid?
    order = Order.find(id)
    if order.price > 0
      valid = true
    else
      valid = false
    end
  end

  def self.pendingOrders
    all.where(status: "notdelivered").order(id: :asc)
  end

  def self.deliveredOrders
    all.where(status: "delivered").order(id: :asc)
  end

  def totalPrice
    total_price = 0
    order_items.each do |order_item|
      total_price += order_item.total
    end
    total_price
  end
end
