class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_params, if: :devise_controller?
    
  private

  def configure_permitted_params
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(:profession , :remember_me, :firstname, :lastname, :email, :phone_number, :password, :password_confirmation)
    end 

    devise_parameter_sanitizer.permit(:account_update) { |user_params| user_params.permit(:firstname, :lastname, :email, :phone_number, :password, :password_confirmation,  :current_password, :profession)}
    
  end
end
