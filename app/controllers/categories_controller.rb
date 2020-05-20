class CategoriesController < ApplicationController
  def index
    categories = Category.all
    render "index", locals: { categories: categories }
  end

  def create
    name = params[:name]
    category = Category.new(name: name)
    if category.valid?
      category.save
      flash[:notice] = "#{category.name} category added successfully"
    else
      flash[:error] = category.errors.full_messages.join(", ")
    end
    redirect_to categories_path
  end

  def destroy
    id = params[:id]
    category = Category.find(id)
    category.destroy
    redirect_to categories_path
  end
end
