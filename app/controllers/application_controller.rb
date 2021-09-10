class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :configure_account_update_parammeters, if: :devise_controller?

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname,:image])
  end

  def configure_account_update_parammeters
    devise_parameter_sanitizer.permit(:account_update, keys: [:nickname, :image])
   end
end
