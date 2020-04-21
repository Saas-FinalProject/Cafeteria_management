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

  def new
    render "new"
  end

  def create
    name = params[:name]
    menu = Menu.new(name: name, active: false)
    if menu.valid?
      menu.save
      redirect_to menus_path
    else
      flash[:error] = menu.errors.full_messages.join(", ")
      redirect_to new_menu_path
    end
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
