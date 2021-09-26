class ApplicationController < ActionController::Base
  helper_method :current_user,
                :logged_in?

  private

  def authenticate_user!
    unless current_user
      cookies[:redirect_path] = redirect_path
      puts cookies[:redirect_path].inspect
      redirect_to login_path, notice: 'Пожалуйста авторизуйтесь'
    else
      delete_redirect_cookies
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end

  def redirect_path
    request.request_method_symbol != :delete ? request.path : parent_path(request.path)
  end

  def parent_path(path)
    until path.last == '/'
      path.chop!
    end
    path
  end

  def delete_redirect_cookies
    cookies.delete :redirect_path if cookies[:redirect_path].present?
  end
end
