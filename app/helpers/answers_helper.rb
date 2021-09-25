module AnswersHelper
  include GeneralHelper

  def answer_header(answer)
    "#{CREATE_OR_EDIT_HEADER_TEXT[answer.new_record?]} ответа на вопрос \"#{answer.question.body}\""
  end

  def answer_saver_text(answer)
    "#{CREATE_OR_EDIT_SAVER_TEXT[answer.new_record?]} ответа на вопрос"
  end

  def delete_answer(answer)
    link_to 'Удалить',
            answer_path(answer),
            method: :delete,
            data: { confirm: 'Вы действительно хотите удалить этот ответ на вопрос?' }
  end
end
