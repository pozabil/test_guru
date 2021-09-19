module QuestionsHelper
  include GeneralHelper

  def question_header(test)
    "#{CREATE_OR_EDIT_HEADER_TEXT[controller.action_name.to_sym]} вопроса в тесте #{test.title}"
  end

  def question_saver_text
    "#{CREATE_OR_EDIT_SAVER_TEXT[controller.action_name.to_sym]} вопрос"
  end

  def delete_question(question)
    link_to 'Удалить',
            question_path(question),
            method: :delete,
            data: { confirm: 'Вы действительно хотите удалить этот вопрос?' }
  end
end
