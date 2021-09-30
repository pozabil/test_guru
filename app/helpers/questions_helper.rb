module QuestionsHelper
  include GeneralHelper

  def question_header(question)
    "#{CREATE_OR_EDIT_HEADER_TEXT[question.new_record?]} вопроса в тесте \"#{question.test.title}\""
  end

  def question_saver_text(question)
    "#{CREATE_OR_EDIT_SAVER_TEXT[question.new_record?]} вопрос"
  end

  def delete_question(question)
    link_to 'Удалить',
            admin_question_path(question),
            method: :delete,
            data: { confirm: 'Вы действительно хотите удалить этот вопрос?' }
  end
end
