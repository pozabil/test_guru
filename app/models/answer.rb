class Answer < ApplicationRecord
  belongs_to :question

  validates :body, presence: true
  validates_associated :question

  scope :only_correct, -> { where(correct: true) }
end
