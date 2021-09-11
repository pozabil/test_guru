class Answer < ApplicationRecord
  belongs_to :question

  validates :body, presence: true

  scope :only_correct, -> { where(correct: true) }
end
