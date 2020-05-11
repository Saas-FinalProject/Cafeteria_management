class Applicant < ActiveRecord::Base
  def self.franchise
    order(:id).where(option: "franchise")
  end

  def self.clerks
    order(:id).where(option: "clerk")
  end

  def self.deliveryBoys
    order(:id).where(option: "deliveryBoy")
  end

  def self.cleaners
    order(:id).where(option: "cleaner")
  end

  def self.category(option)
    if option == "franchise"
      franchise
    elsif option == "clerk"
      clerks
    elsif option == "deliveryBoy"
      deliveryBoys
    else
      cleaners
    end
  end
end
