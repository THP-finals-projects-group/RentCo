class AdminMailer < Devise::Mailer
    default from: 'me@mailjet.com'
    layout 'mailer'

  # AdminMailer.welcome_email.deliver_now
  def welcome_email()
    mail(from: "me@mailjet.com", to: @user.email,
         subject: "This is a nice welcome email")
  end

  # Allow Admin to approve User Registration
  def new_user_waiting_for_approval(email)
    @email = email
    mail(to: "admin-rentco@yopmail.com", subject: "New User Awaiting Admin Approval")
  end
end
