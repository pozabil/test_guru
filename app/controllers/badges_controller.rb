class BadgesController < ApplicationController
  before_action :authenticate_user!, except: :index

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_badges_not_found

  def index
    @badges = Badge.all
  end

  def show
    @badge = Badge.find(params[:id])
  end

  private

  def rescue_with_badges_not_found
    render inline: t('errors.badge_not_found')
  end
end
