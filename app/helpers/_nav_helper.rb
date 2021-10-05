module NavHelper
  def home_link
    link_to 'TestGuru', (current_user.present? && current_user.admin?) ? admin_root_path : root_path
  end

  def signup_link
    link_to t('signup'), new_user_registration_path
  end

  def login_link
    link_to t('login'), new_user_session_path
  end

  def logout_link
    link_to t('logout'),
            destroy_user_session_path,
            method: :delete,
            data: { confirm: t('logout_confirm') }
  end
end
