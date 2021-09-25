module TestPassagesHelper
  def result_message(test_passage)
    passage_message, percent_color =
      if test_passage.success?
        ['успешно пройден', 'green']
      else
        ['не пройден', 'red']
      end

    message = "Тест \"#{test_passage.test.title}\" #{passage_message} с результатом" \
    " <font color=#{percent_color}>#{test_passage.percentage_result}%</font> !"
    content_tag(:h1, message.html_safe)
  end
end
