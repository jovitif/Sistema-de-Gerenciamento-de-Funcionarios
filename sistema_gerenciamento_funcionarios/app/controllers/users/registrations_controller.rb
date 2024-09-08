class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?

  def create
    super do |user|
      if user.gestor_rh?
        departamentos = Departamento.where(id: params[:user][:departamento_ids])
        user.departamentos = departamentos
      end
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nome, :role,departamento_ids: []])
    devise_parameter_sanitizer.permit(:account_update, keys: [:nome, :role,departamento_ids: []])
  end
end