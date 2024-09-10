class CargosController < ApplicationController
  before_action :set_cargo, only: %i[show edit update destroy]

  def index
    if current_user.admin?
      # Admin vê todos os cargos
      if params[:nome].present?
        @cargos = Cargo.where('nome LIKE ?', "%#{params[:nome]}%")
      else
        @cargos = Cargo.all
      end
    elsif current_user.gestor_rh?
      # Gestor de RH vê apenas os cargos de seu departamento
      if params[:nome].present?
        @cargos = Cargo.joins(:departamento).where(departamento: { id: current_user.departamentos.ids }).where('cargos.nome LIKE ?', "%#{params[:nome]}%")
      else
        @cargos = Cargo.joins(:departamento).where(departamento: { id: current_user.departamentos.ids })
      end
    end
  end

  def show
  end

  def new
    @cargo = Cargo.new
    # Verifica se o usuário é admin para exibir todos os departamentos
    @departamentos = current_user.admin? ? Departamento.all : current_user.departamentos_permitidos
  end

  def create
    @cargo = Cargo.new(cargo_params)

    # Verifica se o usuário pode criar cargos para o departamento escolhido
    if current_user.admin? || current_user.departamentos_permitidos.include?(@cargo.departamento)
      if @cargo.save
        redirect_to @cargo, notice: 'Cargo criado com sucesso.'
      else
        render :new
      end
    else
      flash[:alert] = "Você não tem permissão para criar cargos para este departamento."
      render :new
    end
  end

  def edit
  end

  def update
    if @cargo.update(cargo_params)
      redirect_to @cargo, notice: 'Cargo atualizado com sucesso.'
    else
      render :edit
    end
  end

  def destroy
    @cargo.destroy
    redirect_to cargos_url, notice: 'Cargo excluído com sucesso.'
  end

  private

  def set_cargo
    @cargo = Cargo.find(params[:id])
  end

  def cargo_params
    params.require(:cargo).permit(:nome, :descricao, :departamento_id, :nivel, :salario_base, :requisitos, :beneficios, :status)
  end
  
end

