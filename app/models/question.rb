class Question < ApplicationRecord
  belongs_to :test
  has_many :answers

  validates :body, presence: true
  validate :validate_number_of_answers

  private

  def validate_number_of_answers
    errors.add(:base, 'wrong number of answers') unless answers.size.between?(1, 4)
  end
end
