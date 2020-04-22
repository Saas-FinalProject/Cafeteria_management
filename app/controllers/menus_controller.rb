class MenusController < ApplicationController
  def index
    render "index"
  end

  def updateActiveMenu
    activeMenuId = params[:ActiveMenu]
    menu = Menu.find(activeMenuId)
    menu.makeActive
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
    else
      flash[:error] = "Cannot delete Active Menu"
    end
    redirect_to menus_path
  end
end
