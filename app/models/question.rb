class Question < ApplicationRecord
  has_many :answers, dependent: :delete_all
  validates :query, presence: true, length: {minimum: 10}
end
