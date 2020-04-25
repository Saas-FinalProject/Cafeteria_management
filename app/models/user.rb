class User < ActiveRecord::Base
  has_many :orders
  has_secure_password
  validates :name, presence: true
  validates :email, presence: true
  validates :address, presence: true

  def self.clerks
    order(:id).where(role: "clerk")
  end

  def self.customers
    order(:id).where(role: "customer")
  end

  def self.category(role)
    if role == "clerk"
      clerks
    else
      customers
    end
  end
end
