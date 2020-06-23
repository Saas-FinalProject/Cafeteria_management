class OthersController < ApplicationController
  before_action :ensure_owner_or_clerk_logged_in, only: [:termsAndConditionsShow, :termsAndConditionsUpdate, :socialMediaHandlesShow, :socialMediaHandlesUpdate, :cafeAddressShow, :cafeAddressUpdate]

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
    Rails.cache.write("TermsAndConditions", @terms_and_conditions)
    redirect_to "/TermsAndConditionsDisplay"
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
