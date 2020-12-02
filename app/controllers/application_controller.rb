class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_params, if: :devise_controller?

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || users_path
  end

  
  private

  def configure_permitted_params
     devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:firstname, :lastname, :phone_number, :email, :password, :password_confirmation) }
     devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:firstname, :lastname, :phone_number, :email, :password, :current_password, :password_confirmation) }
  end
end
