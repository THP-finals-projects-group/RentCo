class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable,
  :confirmable
  
  enum role: { user: 0, administrator: 1 }

  #Mailer
  after_create :send_admin_mail
  
  # DB RELATIONS
  has_many :cases
  
  # VALIDATES
  validates_presence_of   :firstname, :lastname, :phone_number, :profession, :role

  validates               :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "is not a valid email" }
  validates               :firstname, length: {in: 3...64, message: "must be between 3 and 64 characters"}, presence: true
  validates               :lastname, length: {in: 3...64, message: "must be between 3 and 64 characters"}, presence: true
  validates               :phone_number, uniqueness: {case_sensitive: false, message: "is already taken" }, format: { with: /\A(?:(?:\+|00)33[\s.-]{0,3}(?:\(0\)[\s.-]{0,3})?|0)[1-9](?:(?:[\s.-]?\d{2}){4}|\d{2}(?:[\s.-]?\d{3}){2})\z/, message: "is not a valid french number" }

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

  def self.send_account_blocked_mail(email)
    AdminMailer.account_blocked(email).deliver
  end

  def self.send_case_confirmed_mail(email)
    AdminMailer.case_confirmed(email).deliver
  end
end

