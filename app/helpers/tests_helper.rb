module TestsHelper
  TEST_LEVELS = {
    0 => 'Легкий',
    1 => 'Нормальный',
    2 => 'Продвинутый',
    3 => 'Сложный'
  }.freeze

  include GeneralHelper

  def test_header(test)
    "#{CREATE_OR_EDIT_HEADER_TEXT[test.new_record?]} теста"
  end

  def test_saver_text(test)
    "#{CREATE_OR_EDIT_SAVER_TEXT[test.new_record?]} тест"
  end

  def delete_test(test)
    link_to 'Удалить',
            admin_test_path(test),
            method: :delete,
            data: { confirm: user_signed_in? ? 'Вы действительно хотите удалить этот тест?' : nil }
  end

  def test_level(test)
    TEST_LEVELS[test.level] || 'Героический'
  end
end
