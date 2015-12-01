class UserMailer < ApplicationMailer
  def send_mail_reminder exam
    @exam = exam
    mail to: @exam.user.email, subject: t("reminder")
  end
end
