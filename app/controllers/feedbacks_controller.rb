class FeedbacksController < ApplicationController
  def new; end

  def create
    FeedbackMailer.send_message(feedback_params).deliver_now
      flash[:success] = t('.success')
      redirect_to new_feedback_path
  end

  private

  def feedback_params
    params.permit(:from, :subject, :body)
  end
end
