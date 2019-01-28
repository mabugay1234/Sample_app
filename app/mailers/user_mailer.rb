class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    mail to: user.email, subject: t("account_activation")
  end

  def password_reset
    @greeting = t "user_maile_hi"

    mail to: "to@example.org"
  end
end
