class Question < ApplicationRecord
  belongs_to :test
  has_many :answers, dependent: :destroy
  has_many :gists, dependent: :destroy
  has_many :test_passages, dependent: :destroy, foreign_key: 'current_question_id'

  validates :body, presence: true

  def has_no_correct_answers?
    answers.only_correct.size == 0
  end
end
