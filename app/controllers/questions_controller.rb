class QuestionsController < ApplicationController
  before_action :ensure_owner_or_clerk_logged_in, only: [:show]

  def index
    role = "customer"
    role = current_user.role if current_user
    render "index", locals: { role: role }
  end

  def create
    name = "Anonymous"
    name = current_user.name if current_user

    query = params[:query]
    question = Question.new(name: name, query: query)

    if question.valid?
      question.save
      flash[:notice] = "Question added successfully"
    else
      flash[:error] = question.errors.full_messages.join(", ")
    end

    redirect_to questions_path
  end

  def show
    id = params[:id]
    question = Question.find(id)
    render "show", locals: { question: question }
  end
end
