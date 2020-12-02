class User < ApplicationRecord
  after_create :send_admin_mail
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  enum role: { user: 0, administrator: 1 }
  
  def active_for_authentication? 
    super && approved? 
  end 
  
  def inactive_message 
    approved? ? super : :not_approved
  end

  def send_admin_mail
    AdminMailer.new_user_waiting_for_approval(email).deliver
  end

  def self.send_account_approval_mail(email)
    AdminMailer.account_approval(email).deliver
  end

  ## Add restriction for user to reset password
  # def self.send_reset_password_instructions(attributes={})
  #   recoverable = find_or_initialize_with_errors(reset_password_keys, attributes, :not_found)
  #   if !recoverable.approved?
  #     recoverable.errors[:base] << I18n.t("devise.failure.not_approved")
  #   elsif recoverable.persisted?
  #     recoverable.send_reset_password_instructions
  #   end
  #   recoverable
  # end

  #validates_presence_of :firstname, :lastname, :phone_number, :role
end

