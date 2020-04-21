class UsersController < ApplicationController
  def index
    render plain: "Users controller"
  end

  def new
    render "new"
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

    #validations
    if user.valid?
      user.save
      session[:current_user_id] = user.id
      render plain: "#{user.role} created successfully"
    else
      flash[:error] = user.errors.full_messages.join(", ")
      redirect_to new_user_path
    end
  end
end
