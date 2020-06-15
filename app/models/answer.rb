class Answer < ApplicationRecord
  belongs_to :question
  validates :solution, presence: true
end
