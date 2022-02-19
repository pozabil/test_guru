class UserBadgesController < ApplicationController
  before_action :authenticate_user!, except: :index

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_badges_not_found

  def index
    @user_badges = current_user.user_badges
  end

  def show
    @user_badge = current_user.user_badges.find(params[:id])
  end

  private

  def rescue_with_badges_not_found
    render inline: t('errors.badge_not_found')
  end
end
