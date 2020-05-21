class MenuItemsController < ApplicationController
  def index
    render plain: "MenuItems controller"
  end

  def create
    name = params[:name]
    description = params[:description]
    price = params[:price]
    menu_id = session[:current_selected_menu_id]
    category_id = params[:category_id]
    new_menu_item = MenuItem.new(name: name, description: description, price: price, menu_id: menu_id, category_id: category_id, active: false)

    if new_menu_item.valid?
      new_menu_item.save
    else
      flash[:error] = new_menu_item.errors.full_messages.join(", ")
    end
    redirect_to "/menus/#{menu_id}"
  end

  def update
    id = params[:id]
    if params[:active]
      active = true
    else
      active = false
    end
    menu_item = MenuItem.find(id)
    menu_item.active = active
    menu_item.save
    redirect_to "/menus/#{menu_item.menu_id}"
  end

  def destroy
    id = params[:id]
    menu_item = MenuItem.find(id)
    orders = Order.where(status: "notprocessed")
    orders.each do |order|
      if order.order_items
        order_item = order.order_items.find_by(menu_item_id: menu_item.id)
        if order_item
          order_item.destroy
        end
      end
    end
    menu_item.destroy
    redirect_to "/menus/#{session[:current_selected_menu_id]}"
  end
end
