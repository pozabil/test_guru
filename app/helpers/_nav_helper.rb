module NavHelper
  def home_link
    link_to 'TestGuru', root_path
  end

  def signup_link
    link_to 'Регистрация', signup_path
  end

  def login_link
    link_to 'Войти', login_path
  end

  def logout_link
    link_to 'Выйти',
            logout_path,
            method: :delete,
            data: { confirm: 'Вы действительно хотите выйти?' }
  end
end
