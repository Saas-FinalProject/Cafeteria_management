class OrdersController < ApplicationController
  def index
    if @current_user.role == "customer"
      orders = @current_user.orders
    else
      orders = Order.order(id: :desc).all
    end
    pending_orders = orders.pendingOrders
    delivered_orders = orders.deliveredOrders
    render "index", locals: { pending_orders: pending_orders, delivered_orders: delivered_orders }
  end

  def deliverOrder
    id = params[:id]
    order = Order.find(id)
    order.status = "delivered"
    order.delivered_at = DateTime.now
    order.save
    redirect_to orders_path
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
    order.order_items.each do |order_item|
      if order_item.quantity <= 0
        OrderItem.destroy(order_item.id)
      end
    end
    if @current_user.role == "customer"
      order.status = "notdelivered"
      order.save
      session[:current_order_id] = nil
      redirect_to "/orders#index"
    else
      order.status = "delivered"
      order.delivered_at = DateTime.now
      order.save
      session[:current_order_id] = nil
      redirect_to menus_path
    end
  end

  def getInvoice
    order = Order.find(params[:id])
    render "invoice", locals: { order: order }
  end
end
