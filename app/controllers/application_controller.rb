class ApplicationController < ActionController::Base
  before_action :setUser, :getTwitterHandle, :getInstagramHandle, :getFacebookHandle, :getCafeAddress

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

  def ensure_user_logged_in
    unless current_user
      flash[:error] = "User should Sign in"
      redirect_to new_session_path
    end
  end

  def ensure_owner_logged_in
    unless current_user && current_user.role == "owner"
      flash[:error] = "Admin previlages cannot be accessed"
      redirect_to "/"
    end
  end

  def ensure_owner_or_clerk_logged_in
    unless current_user && current_user.role != "customer"
      flash[:error] = "Staff previlages cannot be accessed"
      redirect_to "/"
    end
  end

  def getTwitterHandle
    if Rails.cache.fetch("TwitterHandle")
      @twitter_handle = Rails.cache.read("TwitterHandle")
    else
      @twitter_handle = nil
    end
  end

  def getInstagramHandle
    if Rails.cache.fetch("InstagramHandle")
      @instagram_handle = Rails.cache.read("InstagramHandle")
    else
      @instagram_handle = nil
    end
  end

  def getFacebookHandle
    if Rails.cache.fetch("FacebookHandle")
      @facebook_handle = Rails.cache.read("FacebookHandle")
    else
      @facebook_handle = nil
    end
  end

  def getCafeAddress
    if Rails.cache.fetch("AddressLine1")
      @address_line1 = Rails.cache.read("AddressLine1")
    else
      @address_line1 = nil
    end
    if Rails.cache.fetch("AddressLine2")
      @address_line2 = Rails.cache.read("AddressLine2")
    else
      @address_line2 = nil
    end
    if Rails.cache.fetch("AddressLine3")
      @address_line3 = Rails.cache.read("AddressLine3")
    else
      @address_line3 = nil
    end
    if Rails.cache.fetch("AddressLine4")
      @address_line4 = Rails.cache.read("AddressLine4")
    else
      @address_line4 = nil
    end
  end
end
