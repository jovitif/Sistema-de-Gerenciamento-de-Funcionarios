# app/controllers/users_controller.rb
class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :admin_only
  
    def index
      @users = User.includes(:departamentos).all
    end
    
    def new
      @user = User.new
    end
  
    def create
      @user = User.new(user_params)
      if @user.save
        puts "Administrador #{current_user.email} criou um novo usuário #{@user.email}"
        redirect_to users_path, notice: 'Usuário cadastrado com sucesso.'
      else
        puts "Erro ao criar usuário"
        render :new
      end
    end
    
  
    private
  
    def admin_only
      unless current_user.admin?
        redirect_to root_path, alert: 'Acesso negado!'
      end
    end
  
  
    def user_params
      params.require(:user).permit(:nome, :email, :password, :password_confirmation, :role, departamento_ids: [])
    end
  end
  