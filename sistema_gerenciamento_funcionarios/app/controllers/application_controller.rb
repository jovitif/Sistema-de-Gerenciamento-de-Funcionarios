class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern



  include Pundit

  # Garante que o pundit lance um erro quando uma autorização falhar
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = "Você não está autorizado a realizar essa ação."
    redirect_to(request.referrer || new_user_session_path)  # Isso redireciona para a página de login do Devise
  end
  

  def update_sanitized_params
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:nome, :email, :password, :password_confirmation,role)}
    devise_parameter_sanitizer.for(:account_update) {|u| u.permit(:nome, :email, :password, :password_confirmation, :current_password,role)}
  end

  def after_sign_in_path_for(resource)
    selection_path # redireciona para a página de seleção
  end

  
end
