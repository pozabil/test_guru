module NavHelper
  def home_link
    link_to 'TestGuru', (current_user.present? && current_user.admin?) ? admin_root_path : root_path
  end

  def signup_link
    link_to 'Регистрация', new_user_registration_path
  end

  def login_link
    link_to 'Войти', new_user_session_path
  end

  def logout_link
    link_to 'Выйти',
            destroy_user_session_path,
            method: :delete,
            data: { confirm: 'Вы действительно хотите выйти?' }
  end
end
