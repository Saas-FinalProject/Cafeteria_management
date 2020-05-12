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
    render "index"
  end

  def updateActiveMenu
    activeMenuId = params[:ActiveMenu]
    menu = Menu.find(activeMenuId)
    menu.makeActive
    orders = Order.where(status: "notprocessed")
    orders.order_items.destroy_all
    orders.destroy
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
    redirect_to menus_path
  end

  def show
    id = params[:id]
    session[:current_selected_menu_id] = id
    menu = Menu.find(id)
    render "display_menu", locals: { menu: menu }
  end

  def destroy
    id = params[:id]
    menu = Menu.find(id)
    unless menu.isActive?
      menu.destroy
      session[:current_order_id] = nil
    else
      flash[:error] = "Cannot delete Active Menu"
    end
    redirect_to menus_path
  end

  def changeMenu
    render "menus/_owner"
  end
end
