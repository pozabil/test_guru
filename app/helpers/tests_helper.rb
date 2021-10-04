module TestsHelper
  def delete_test(test)
    link_to t('delete'),
            admin_test_path(test),
            method: :delete,
            data: { confirm: user_signed_in? ? t('helpers.tests_helper.delete_confirmation') : nil }
  end

  def test_level(test)
    test_levels = {
      0 => t('test_levels.easy'),
      1 => t('test_levels.normal'),
      2 => t('test_levels.advanced'),
      3 => t('test_levels.hard')
    }
    test_levels[test.level] || t('test_levels.heroic')
  end
end
