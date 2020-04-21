class UsersController < ApplicationController
  def index
    render plain: "Users controller"
  end

  def new
    render "new"
  end
end
