class Question < ApplicationRecord
  has_many :answers
  validates :query, presence: true
end
