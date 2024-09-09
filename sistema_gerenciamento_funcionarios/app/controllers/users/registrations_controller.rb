class Users::RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  #before_action :admin_only, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(sign_up_params)
    if @user.save
      if @user.gestor_rh?
        departamentos = Departamento.where(id: params[:user][:departamento_ids])
        @user.departamentos = departamentos
      end
      redirect_to users_path, notice: 'Usuário cadastrado com sucesso.'
    else
      render :new
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nome, :role, departamento_ids: []])
    devise_parameter_sanitizer.permit(:account_update, keys: [:nome, :role, departamento_ids: []])
  end

  private

 
end
