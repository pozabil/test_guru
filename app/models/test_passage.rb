class TestPassage < ApplicationRecord
  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', optional: true

  before_validation :before_validation_set_first_question, on: :create
  before_update :before_update_next_question

  def accept!(answer_ids)
    self.correct_questions += 1 if correct_answer?(answer_ids)
    save!
  end

  def completed?
    current_question.nil?
  end

  def expired?
    test.timer > 0 && (test.timer <= ((Time.now - created_at)/1.minutes))
  end

  def set_completed!
    self.current_question = nil
    save!
  end

  def percentage_result
    ((correct_questions.to_f / test.questions.size) * 100).round(2)
  end

  private

  def before_validation_set_first_question
    return unless test.present?

    self.current_question = test.questions.order(:id).first
    self.current_question_number = 1
  end

  def before_update_next_question
    self.current_question = test.questions.order(:id).where('id > ?', current_question.id).first if self.current_question != nil
    self.current_question_number = completed? ? nil : (current_question_number + 1)
  end

  def correct_answer?(answer_ids)
    correct_answers.ids.sort == answer_ids.to_a.map(&:to_i).sort
  end

  def correct_answers
    current_question.answers.only_correct
  end
end
