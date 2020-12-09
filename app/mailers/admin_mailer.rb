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

  # Allow Admin to block User account
  def account_blocked(email)
    mail(from: "admin-rentco@yopmail.com", to: email, subject: "Votre compte est désactivé")
  end

  # Admin inform user of a new case
  def new_case(cases)
    @case = cases
    mail(from: "admin-rentco@yopmail.com", to: @case.user.email, subject: "#{@case.user.email} à soumis un nouveau dossier")
  end
  
  # Admin inform user that a case is closed and a pdf is available
  def case_confirmed(email)
    mail(from: "admin-rentco@yopmail.com", to: email, subject: "Le dossier confirmé et pdf disponible")
  end
end
