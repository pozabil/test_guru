module AnswersHelper
  def delete_answer(answer)
    link_to t('delete'),
            admin_answer_path(answer),
            method: :delete,
            data: { confirm: t('helpers.answers_helper.delete_confirmation') },
            class: "link-danger"
  end
end
