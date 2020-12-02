class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || users_path
  end

  # before_action :configure_permitted_params, if: :devise_controller?
  
  # private

  # def configure_permitted_params
  #   devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:firstname, :lastname, :avatar, :email, :password) }
  #   devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:firstname, :lastname, :avatar, :email, :password, :current_password) }
  # end
end
