class ApplicantsController < ApplicationController
  before_action :ensure_owner_or_clerk_logged_in, only: [:index]

  def index
    render "index"
  end

  def new
    render "new"
  end

  def create
    name = params[:name]
    email = params[:email]
    option = params[:option]
    phone = params[:phone]
    address = params[:address]

    applicant = Applicant.new(name: name, email: email, option: option, phone: phone, address: address)

    if applicant.valid?
      applicant.save
      flash[:notice] = "Application submitted successfully"
      redirect_to "/"
    else
      flash[:error] = applicant.errors.full_messages.join(", ")
      redirect_to new_applicant_path
    end
  end

  def destroy
    id = params[:id]
    applicant = Applicant.find(id)
    applicant.destroy
    redirect_to applicants_path
  end
end
