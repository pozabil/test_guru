module TestsHelper

  TEST_LEVELS = {
    0 => 'Легкий',
    1 => 'Нормальный',
    2 => 'Продвинутый',
    3 => 'Сложный'
  }

  include GeneralHelper

  def test_header
    "#{CREATE_OR_EDIT_HEADER_TEXT[controller.action_name.to_sym]} теста"
  end

  def test_saver_text
    "#{CREATE_OR_EDIT_SAVER_TEXT[controller.action_name.to_sym]} вопрос"
  end

  def delete_test(test)
    link_to 'Удалить',
            test_path(test),
            method: :delete,
            data: { confirm: 'Вы действительно хотите удалить этот тест?' }
  end

  def test_level(test)
    TEST_LEVELS[test.level] || 'Героический'
  end
end
