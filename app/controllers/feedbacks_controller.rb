class FeedbacksController < ApplicationController
  FEEDBACK_FORM_PARAMETERS = [:from, :subject, :body]

  def show
    redirect_to new_feedback_path
  end

  def new
    @previous_feedback_params = previous_feedback_params
    delete_feedback_params_cookies
  end

  def create
    if FeedbackMailer.feedback_message(feedback_params).deliver_now
      flash[:success] = t('.success')
    else
      flash[:alert] = t('.fail')
      store_feedback_params
    end
    redirect_to new_feedback_path
  end

  private

  def feedback_params
    params.permit(FEEDBACK_FORM_PARAMETERS)
  end

  def store_feedback_params
    feedback_params.each { |k, v| cookies[k] = v if v.present? }
  end

  def previous_feedback_params
    feedback_params_hash = {}
    FEEDBACK_FORM_PARAMETERS.each { |k| feedback_params_hash[k] = cookies[k] if cookies[k].present? }
    feedback_params_hash
  end

  def delete_feedback_params_cookies
    FEEDBACK_FORM_PARAMETERS.each { |k| cookies.delete(k) if cookies[k].present? }
  end
end
