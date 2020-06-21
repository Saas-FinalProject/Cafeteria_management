class AnswersController < ApplicationController
  def create
    question_id = params[:question_id]
    solution = params[:solution]
    answer = Answer.new(question_id: question_id, solution: solution)
    if answer.valid?
      answer.save
      flash[:notice] = "Answer added successfully"
      redirect_to questions_path
    else
      flash[:error] = answer.errors.full_messages.join(", ")
      redirect_to "/questions/#{question_id}"
    end
  end
end
