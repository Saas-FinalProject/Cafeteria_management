class OrdersController < ApplicationController
  def index
    if User.find(session[:current_user_id]).role == "customer"
      orders = Order.where(user_id: session[:current_user_id])
      orders = orders.select { |orders| orders[:status] != "notprocessed" }
    else
      orders = Order.all
      orders = orders.select { |orders| orders[:status] != "notprocessed" }
    end

    render "index", locals: { orders: orders }
  end

  def new
  end

  def create
  end

  def deliverOrder
    id = params[:id]
    order = Order.find(id)
    order.status = "delivered"
    order.delivered_at = Date.today.to_s
    order.save
    redirect_to "/orders#index"
  end

  def cart
    if session[:current_order_id] == nil
      flash[:error] = "Your Cart Is Empty"
      redirect_to menus_path
    else
      order = Order.find(session[:current_order_id])
      order.price = 0
      order.order_items.each do |order_item|
        order.price = order.price + order_item.menu_item_price * order_item.quantity
      end
      order.save
      if order.price > 0
        render "cart", locals: { order: order }
      else
        flash[:error] = "Your cart Is empty,select an item,May be the Items You added had removed by owner"
        redirect_to menus_path
      end
    end
  end

  def confirm
    order = Order.find(session[:current_order_id])
    order.status = "notdelivered"
    order.save
    order.order_items.each do |order_item|
      if order_item.quantity <= 0
        OrderItem.destroy(order_item.id)
      end
    end
    session[:current_order_id] = nil
    redirect_to "/orders#index"
  end
end
