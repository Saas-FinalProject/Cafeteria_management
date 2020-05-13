class UsersController < ApplicationController
  def index
    render "index"
  end

  def new
    @signUpFlag = true
    render "home/index"
  end

  def create
    name = params[:name]
    email = params[:email]
    password = params[:password]
    phone = params[:phone]
    address = params[:address]
    role = params[:role]

    role = "customer" unless role

    user = User.new(name: name, email: email, password: password, phone: phone, address: address, role: role)

    if user.valid?
      user.save
      session[:current_user_id] = user.id
      redirect_to menus_path
    else
      flash[:error] = user.errors.full_messages.join(", ")
      redirect_to new_user_path
    end
  end

  def removeAsClerk
    id = params[:id]
    user = User.find(id)
    user.role = "customer"
    user.save
    redirect_to users_path
  end

  def makeAsClerk
    id = params[:id]
    user = User.find(id)
    user.role = "clerk"
    user.save
    redirect_to users_path
  end
end
