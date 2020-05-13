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

  def self.pendingOrders
    all.where(status: "notdelivered").order(date: :asc)
  end

  def self.deliveredOrders
    all.where(status: "delivered").order(date: :asc)
  end
end
