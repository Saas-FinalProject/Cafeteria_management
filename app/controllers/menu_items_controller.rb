class MenuItemsController < ApplicationController
  before_action :ensure_owner_logged_in

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

  def edit
    id = params[:id]
    menu_item = MenuItem.find(id)
    categories = Category.displayable
    menus = Menu.displayable
    render "menu_item_edit", locals: { menu_item: menu_item, categories: categories, menus: menus }
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
    if active == false
      orders = Order.where(status: "notprocessed")
      if orders
        orders.each do |order|
          if order.order_items
            order.order_items.each do |order_item|
              if order_item.menu_item_id == menu_item.id
                order_item.destroy
              end
            end
          end
        end
      end
    end
    redirect_to "/menus/#{menu_item.menu_id}"
  end

  def updateMenuItem
    id = params[:id]
    menu_item = MenuItem.find(id)
    menu_item.name = params[:name]
    menu_item.description = params[:description]
    menu_item.price = params[:price]
    menu_item.menu_id = params[:menu_id]
    menu_item.category_id = params[:category_id]
    if menu_item.valid?
      menu_item.save
      flash[:notice] = "update successfull"
      redirect_to "/menus/#{menu_item.menu_id}"
    else
      flash[:error] = menu_item.errors.full_messages.join(", ")
      redirect_to edit_menu_item_path #"menu_items/#{id}/edit"
    end
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
