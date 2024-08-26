class DepartamentosController < ApplicationController
  before_action :set_departamento, only: %i[show edit update destroy]

  def index
    if params[:nome].present?
      @departamentos = Departamento.where('nome LIKE ?', "%#{params[:nome]}%")
    else
      @departamentos = Departamento.all
    end
  end

  def show
  end

  def new
    @departamento = Departamento.new
  end

  def create
    @departamento = Departamento.new(departamento_params)
    if @departamento.save
      redirect_to @departamento, notice: 'Departamento criado com sucesso.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @departamento.update(departamento_params)
      redirect_to @departamento, notice: 'Departamento atualizado com sucesso.'
    else
      render :edit
    end
  end

  def destroy
    @departamento = Departamento.find(params[:id])
    @departamento.destroy
    redirect_to departamentos_url, notice: 'Departamento excluído com sucesso.'
  end
  

  private

  def set_departamento
    @departamento = Departamento.find(params[:id])
  end

  def departamento_params
    params.require(:departamento).permit(:nome, :descricao, :codigo, :localizacao, :status)
  end
end
