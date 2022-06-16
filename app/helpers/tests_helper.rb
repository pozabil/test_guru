module TestsHelper
  def delete_test(test)
    link_to t('delete'),
            admin_test_path(test),
            method: :delete,
            data: { confirm: user_signed_in? ? t('helpers.tests_helper.delete_confirmation') : nil },
            class: "link-danger"
  end

  def publish_test(test)
    button_to t('publish'),
              publish_admin_test_path(test),
              method: :patch,
              class: "btn btn-success"
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

  def timer_yes_or_no(test)
    test.timer > 0 ? t('yes') : t('no')
  end

  def start_or_continue_test_button(test)
    button_to ((current_user && current_user.has_active_test?(test)) ? t('continue') : t('start')),
              start_test_path(test),
              class: "btn #{((current_user && current_user.has_active_test?(test)) ? "btn-primary" : "btn-success")}",
              style: "width: 8em;"
  end
end
