class User < ActiveRecord::Base
  has_many :orders
  has_secure_password
  validates :name, presence: true
  validates :email, presence: true
  validates :address, presence: true
end
