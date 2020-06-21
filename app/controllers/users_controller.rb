class UsersController < ApplicationController
  before_action :ensure_user_logged_in, only: [:show, :edit]
  before_action :ensure_owner_logged_in, only: [:index]

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
    role = "customer"

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

  def show
    id = params[:id]
    if id.to_i == current_user.id
      user = User.find(id)
      render "show", locals: { user: user }
    else
      flash[:error] = "Hey! You are not allowed to view this page."
      redirect_to "/"
    end
  end

  def edit
    id = params[:id]
    if id.to_i == current_user.id
      user = User.find(id)
      render "profile-edit", locals: { user: user }
    else
      flash[:error] = "Hey! You are not allowed to view this page."
      redirect_to "/"
    end
  end

  def update
    id = params[:id]
    if id.to_i == current_user.id
      user = User.find(id)
      user.name = params[:name]
      user.email = params[:email]
      user.phone = params[:phone]
      user.address = params[:address]
      user.password = params[:new_password] if params[:new_password]
      if user.valid?
        user.save
        flash[:notice] = "Profile Updated successfully"
        redirect_to user_path
      else
        flash[:error] = user.errors.full_messages.join(", ")
        redirect_to edit_user_path
      end
    else
      flash[:error] = "Invalid Update"
      redirect_to "/"
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
