class FeedbackMailer < ApplicationMailer
  def feedback_message(feedback)
    @support_email = Admin.first.email
    @from = feedback[:from]
    @subject = feedback[:subject]
    @body = feedback[:body]

    mail to: @support_email, subject: t('.general_subject')
  end
end
