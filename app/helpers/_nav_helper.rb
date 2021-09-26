module NavHelper
  def home
    link_to 'TestGuru', root_path
  end

  def signup
    link_to 'Регистрация', signup_path
  end

  def login
    link_to 'Войти', login_path
  end

  def logout
    link_to 'Выйти',
            logout_path,
            method: :delete,
            data: { confirm: 'Вы действительно хотите выйти?' }
  end
end