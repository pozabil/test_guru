class Admin::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_required!

  layout 'admin'

  private

  def admin_required!
    redirect_to root_path, alert: 'У вас нет доступа на запрашиваемую страницу' unless current_user.admin?
  end
end
