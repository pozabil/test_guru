class SessionsController < ApplicationController
  def new
    redirect_to root_path if logged_in?
  end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to cookies[:redirect_path].present? ? cookies[:redirect_path] : root_path
    else
      redirect_to login_path, alert: 'Введены неверная почта или пароль'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: 'Вы успешно вышли'
  end
end
