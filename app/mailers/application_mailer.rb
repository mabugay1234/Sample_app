class ApplicationMailer < ActionMailer::Base
  default from: ENV["GMAIL_DEFAULT"]

  def sample_email user
    @user = user
    mail to: @user.email, subject: t("sample_email")
  end
end
