module TestsHelper

  TEST_LEVELS = {
    0 => 'Легкий',
    1 => 'Нормальный',
    2 => 'Продвинутый',
    3 => 'Сложный'
  }

  include GeneralHelper

  def test_header(test)
    "#{CREATE_OR_EDIT_HEADER_TEXT[test.new_record?]} теста"
  end

  def test_saver_text(test)
    "#{CREATE_OR_EDIT_SAVER_TEXT[test.new_record?]} тест"
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
