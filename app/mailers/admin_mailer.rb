class AdminMailer < Devise::Mailer
    default from: 'admin-rentco@yopmail.com'
    layout 'mailer'

  # AdminMailer.welcome_email.deliver_now
  def welcome_email()
    mail(from: "admin-rentco@yopmail.com", to: @user.email,
         subject: "email de bienvenue")
  end

  # Allow Admin to approve User Registration
  def new_user_waiting_for_approval(email)
    @email = email
    mail(to: "admin-rentco@yopmail.com", subject: "Un utilisateur attend votre confirmation pour son compte")
  end

  def account_approval(email)
    mail(from: "admin-rentco@yopmail.com", to: email, subject: "Votre compte est activé")
  end

  def new_case(cases)
    mail(from: "admin-rentco@yopmail.com", to: cases.user.email, subject: "#{cases.user.email} à soumis un nouveau dossier")
  end
end
