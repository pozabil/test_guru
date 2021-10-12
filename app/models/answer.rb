class Answer < ApplicationRecord
  belongs_to :question

  validates :body, presence: true
  validate :validate_number_of_answers, on: :create

  scope :only_correct, -> { where(correct: true) }

  private

  def validate_number_of_answers
    errors.add(:base, 'wrong number of answers') if question.answers.size > 4
  end
end
