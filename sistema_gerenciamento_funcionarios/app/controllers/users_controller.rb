# app/controllers/users_controller.rb
class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :admin_only
  
    def new
      @user = User.new
    end
  
    def create
      @user = User.new(user_params)
      if @user.save
        redirect_to root_path, notice: 'Usuário cadastrado com sucesso.'
      else
        render :new
      end
    end
  
    private
  
    def admin_only
      redirect_to root_path, alert: 'Acesso negado!' unless current_user.admin?
    end
  
    def user_params
      params.require(:user).permit(:nome, :email, :password, :password_confirmation, :role, departamento_ids: [])
    end
  end
  