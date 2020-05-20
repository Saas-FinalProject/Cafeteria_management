class MenusController < ApplicationController
  def index
    order = Order.where(user_id: session[:current_user_id])
    if order
      previous_order = order.find { |order| order[:status] == "notprocessed" }
      if previous_order
        session[:current_order_id] = previous_order.id
      else
        user_id = session[:current_user_id]
        Order.create!(user_id: user_id, date: Date.today, delivered_at: nil, status: "notprocessed", price: 0)
        session[:current_order_id] = Order.last.id
      end
    else
      user_id = session[:current_user_id]
      Order.create!(user_id: user_id, date: Date.today, delivered_at: nil, status: "notprocessed", price: 0)
      session[:current_order_id] = Order.last.id
    end
    displayableCategoryItems = Category.displayableCategoryItems
    render "index", locals: { displayableCategoryItems: displayableCategoryItems }
  end

  def updateActiveMenu
    activeMenuId = params[:ActiveMenu]
    menu = Menu.find(activeMenuId)
    menu.makeActive
    orders = Order.where(status: "notprocessed")
    if orders
      orders.each do |order|
        if order.order_items
          order.order_items.destroy_all
        end
        order.destroy
      end
    end
    session[:current_order_id] = nil
    #render plain: "This is the currently active menu - #{menu.name}"
    redirect_to menus_path
  end

  def create
    name = params[:name]
    menu = Menu.new(name: name, active: false)
    if menu.valid?
      menu.save
    else
      flash[:error] = menu.errors.full_messages.join(", ")
    end
    redirect_to change_menus_path
  end

  def show
    id = params[:id]
    session[:current_selected_menu_id] = id
    menu = Menu.find(id)
    categories = Category.displayable
    render "display_menu", locals: { menu: menu, categories: categories }
  end

  def update
    id = params[:id]
    active = params[:active]
    menu = Menu.find(id)
    menu.active = active
    menu.save
    redirect_to change_menus_path
  end

  def destroy
    id = params[:id]
    menu = Menu.find(id)
    # unless menu.isActive?
    #   menu.destroy
    #   session[:current_order_id] = nil
    # else
    #   flash[:error] = "Cannot delete Active Menu"
    # end
    menu.destroy
    redirect_to change_menus_path
  end

  def changeMenu
    displayableCategoryItems = Category.displayableCategoryItems
    render "activeMenus", locals: { displayableCategoryItems: displayableCategoryItems }
  end
end
