class MenuItemsController < ApplicationController
  def index
    render plain: "MenuItems controller"
  end

  def create
    name = params[:name]
    description = params[:description]
    price = params[:price]
    menu_id = session[:current_selected_menu_id]

    new_menu_item = MenuItem.new(name: name, description: description, price: price, menu_id: menu_id)

    if new_menu_item.valid?
      new_menu_item.save
    else
      flash[:error] = new_menu_item.errors.full_messages.join(", ")
    end
    redirect_to "/menus/#{menu_id}"
  end

  def destroy
    id = params[:id]
    menu_item = MenuItem.find(id)
    menu_item.destroy
    orders = Order.where(status: "notprocessed")
    orders.each do |orders|
      order_item = orders.order_items.find_by(menu_item_id: menu_item.id)
      order_item.destroy
    end
    redirect_to "/menus/#{session[:current_selected_menu_id]}"
  end
end
