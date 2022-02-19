class Admin::BadgesController < Admin::BaseController
  before_action :find_badge, only: %i[show edit update destroy start update_inline]
  before_action :find_badges, only: %i[index update_inline]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_badges_not_found

  def index; end

  def new
    @badge = Badge.new
  end

  def show
    redirect_to edit_admin_badge_path(@badge)
  end

  def create
    @badge = current_user.created_badges.new(badge_params)

    if @badge.save
      flash[:success] = t('.success', badge_title: @badge.title)
      redirect_to admin_badges_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @badge.update(badge_params)
      flash[:success] = t('.success', badge_title: @badge.title)
      redirect_to admin_badges_path
    else
      render :new
    end
  end

  def update_inline
    if @badge.update(badge_params)
      redirect_to admin_badges_path
    else
      render :index
    end    
  end

  def destroy
    @badge.destroy
    redirect_to admin_badges_path, alert: t('.success', badge_title: @badge.title)
  end

  private

  def find_badge
    @badge = Badge.find(params[:id])
  end

  def find_badges
    @badges = Badge.all
  end

  def badge_params
    params.require(:badge).permit(:title, :image_path, :rule, :rule_condition, :description)
  end

  def rescue_with_badges_not_found
    render inline: t('errors.badge_not_found')
  end
end
