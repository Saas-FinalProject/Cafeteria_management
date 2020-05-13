class HomeController < ApplicationController
  def index
    if @current_user
      redirect_to menus_path
    else
      @signUpFlag = false
      render "index"
    end
  end
end
