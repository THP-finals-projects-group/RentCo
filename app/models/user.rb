class User < ApplicationRecord
  after_create :send_admin_mail
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  enum role: { user: 0, administrator: 1 }
  
  # DB RELATIONS
  has_many :cases
  
  # VALIDATES
  validates_presence_of   :firstname, :lastname, :phone_number, :profession, :role

  validates               :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "Entrez une adresse email valide" }
  validates               :firstname, length: {in: 3...64, message: "Votre prénom doit faire entre 3 et 64 caractères"}, presence: true
  validates               :lastname, length: {in: 3...64, message: "Votre nom doit faire entre 3 et 64 caractères"}, presence: true
  validates               :phone_number, uniqueness: {case_sensitive: false, message: "Ce numéro de téléphone est déjà utilisé" }, format: { with: /\A(?:(?:\+|00)33[\s.-]{0,3}(?:\(0\)[\s.-]{0,3})?|0)[1-9](?:(?:[\s.-]?\d{2}){4}|\d{2}(?:[\s.-]?\d{3}){2})\z/, message: "Entrez un numéro de téléphone français valide" }

  validates               :profession, presence: true

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
end

