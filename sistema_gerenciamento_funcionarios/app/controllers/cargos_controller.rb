class CargosController < ApplicationController
  before_action :set_cargo, only: %i[show edit update destroy]

  def index
    @cargos = Cargo.all
  end

  def show
  end

  def new
    @cargo = Cargo.new
  end

  def create
    @cargo = Cargo.new(cargo_params)
    if @cargo.save
      redirect_to @cargo, notice: 'Cargo criado com sucesso.'
    else
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

