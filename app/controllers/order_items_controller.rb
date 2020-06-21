class OrderItemsController < ApplicationController
  def change
    order_item = Order.find(session[:current_order_id]).order_items.find_by(menu_item_id: params[:id])
    if params[:quantity].to_i > 0
      if order_item
        order_item.quantity = params[:quantity]
        order_item.save
      else
        menu_item = MenuItem.find(params[:id])
        OrderItem.create!(order_id: session[:current_order_id], menu_item_name: menu_item.name, menu_item_id: menu_item.id, menu_item_price: menu_item.price, quantity: 1)
      end
    else
      if order_item
        order_item.destroy
      end
    end
    redirect_to menus_path
  end

  def update
    order_item = OrderItem.find(params[:id])
    if params[:quantity].to_i > 0
      order_item.quantity = params[:quantity]
      order_item.save
    else
      order_item.destroy
    end
    redirect_to carts_path
  end
end
