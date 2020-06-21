class OthersController < ApplicationController
  def getTermsAndConditions
    if Rails.cache.fetch("TermsAndConditions")
      @terms_and_conditions = Rails.cache.read("TermsAndConditions")
    else
      @terms_and_conditions = nil
    end
  end

  def termsAndConditionsDisplay
    getTermsAndConditions
    render "TermsAndConditions/display"
  end

  def termsAndConditionsShow
    getTermsAndConditions
    render "TermsAndConditions/show"
  end

  def termsAndConditionsUpdate
    @terms_and_conditions = params[:terms_and_conditions]
    if @terms_and_conditions != ""
      Rails.cache.write("TermsAndConditions", @terms_and_conditions)
      redirect_to "/TermsAndConditionsDisplay"
    else
      flash[:error] = "Terms And Conditions can't be blank"
      redirect_to "/TermsAndConditionsShow"
    end
  end

  def socialMediaHandlesShow
    render "SocialMediaHandles/show"
  end

  def socialMediaHandlesUpdate
    Rails.cache.write("TwitterHandle", params[:twitter_handle])
    Rails.cache.write("InstagramHandle", params[:instagram_handle])
    Rails.cache.write("FacebookHandle", params[:facebook_handle])
    redirect_to "/"
  end

  def cafeAddressShow
    render "CafeAddress/show"
  end

  def cafeAddressUpdate
    Rails.cache.write("AddressLine1", params[:address_line1])
    Rails.cache.write("AddressLine2", params[:address_line2])
    Rails.cache.write("AddressLine3", params[:address_line3])
    Rails.cache.write("AddressLine4", params[:address_line4])
    redirect_to "/"
  end
end
