class FeedbackMailer < ApplicationMailer
  def feedback_message(feedback)
    @support_email = Admin.first.email
    @from = feedback[:from]
    @subject = feedback[:subject]
    @body = feedback[:body]

    ( mail to: @support_email, subject: t('.general_subject') ) if validate_message(@from, @subject, @body)
  end

  private

  def validate_message(from, subject, body)
    !!(from && from.match(URI::MailTo::EMAIL_REGEXP)) && subject.present? && body.present?
  end
end
