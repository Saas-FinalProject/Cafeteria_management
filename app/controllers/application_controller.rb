class ApplicationController < ActionController::Base
  before_action :setUser

  def setUser
    @current_user = current_user
  end

  def current_user
    @current_user if @current_user
    if session[:current_user_id]
      @current_user = User.find(session[:current_user_id])
    else
      nil
    end
  end

  def resetUser
    @current_user = session[:current_user_id] = nil
  end
end
