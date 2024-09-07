class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def update_sanitized_params
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:nome, :email, :password, :password_confirmation,role)}
    devise_parameter_sanitizer.for(:account_update) {|u| u.permit(:nome, :email, :password, :password_confirmation, :current_password,role)}
  end
end
