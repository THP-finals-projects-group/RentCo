class AdminMailer < ApplicationMailer
  # AdminMailer.welcome_email.deliver_now
  def welcome_email()
    mail(from: "me@mailjet.com", to: "you@mailjet.com",
         subject: "This is a nice welcome email")
  end
end
