class UserMailer < ActionMailer::Base
  default from: "notifications@example.com"

  def send_exam_result exam
    @exam = exam
    mail to: exam.user.email, subject: t("mail.exam_result")
  end

  def send_mail_reminder exam
    @exam = exam
    mail to: @exam.user.email, subject: t("reminder")
  end
end
