module TestPassagesHelper
  def result_message(test_passage)
    passage_message, percent_color =
      if test_passage.success.nil?
        [t('helpers.test_passages_helper.interruption', test_title: test_passage.test.title), 'red']
      elsif test_passage.success
        [t('helpers.test_passages_helper.success', test_title: test_passage.test.title), 'green']
      else
        [t('helpers.test_passages_helper.failure', test_title: test_passage.test.title), 'red']
      end

    message = "#{passage_message} <font color=#{percent_color}>#{test_passage.percentage_result}%</font> !"
    message.html_safe
  end
end
