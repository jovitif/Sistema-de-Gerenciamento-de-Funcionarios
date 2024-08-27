# app/controllers/funcionarios_controller.rb

class FuncionariosController < ApplicationController
  before_action :set_funcionario, only: %i[show edit update destroy]

  # GET /funcionarios
  # GET /funcionarios.json
  def index
    def index
      @funcionarios = Funcionario.all
  
      # Filtro por nome
      @funcionarios = @funcionarios.where('nome_completo LIKE ?', "%#{params[:nome]}%") if params[:nome].present?
  
      # Filtro por departamento
      if params[:departamento_id].present?
        departamento_id = params[:departamento_id].to_i
        @funcionarios = @funcionarios.joins(cargo: :departamento).where('departamentos.id = ?', departamento_id)
      end
  
      # Filtro por data de contratação
      if params[:data_contratacao_inicio].present? && params[:data_contratacao_fim].present?
        @funcionarios = @funcionarios.where('data_contratacao BETWEEN ? AND ?', params[:data_contratacao_inicio], params[:data_contratacao_fim])
      elsif params[:data_contratacao_inicio].present?
        @funcionarios = @funcionarios.where('data_contratacao >= ?', params[:data_contratacao_inicio])
      elsif params[:data_contratacao_fim].present?
        @funcionarios = @funcionarios.where('data_contratacao <= ?', params[:data_contratacao_fim])
      end
    end
  end

  # GET /funcionarios/1
  # GET /funcionarios/1.json
  def show
  end

  # GET /funcionarios/new
  def new
    @funcionario = Funcionario.new
    @funcionario.enderecos.build # Adiciona um endereço vazio para o formulário
  end

  # POST /funcionarios
  # POST /funcionarios.json
  def create
    @funcionario = Funcionario.new(funcionario_params)
    if @funcionario.save
      redirect_to @funcionario, notice: 'Funcionário criado com sucesso.'
    else
      render :new
    end
  end
  
  

  # GET /funcionarios/1/edit
  def edit
  end

  # PATCH/PUT /funcionarios/1
  # PATCH/PUT /funcionarios/1.json
  def update
    if @funcionario.update(funcionario_params)
      redirect_to @funcionario, notice: 'Funcionário atualizado com sucesso.'
    else
      render :edit
    end
  end

  # DELETE /funcionarios/1
  # DELETE /funcionarios/1.json
  def destroy
    @funcionario.destroy
    redirect_to funcionarios_url, notice: 'Funcionário excluído com sucesso.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_funcionario
    @funcionario = Funcionario.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  # app/controllers/funcionarios_controller.rb
def funcionario_params
  params.require(:funcionario).permit(
    :nome_completo, :cpf, :email, :data_nascimento, :data_contratacao, :salario, :status, :cargo_id,
    :genero, :rg, :telefone, 
    enderecos_attributes: [:id, :rua, :numero, :bairro, :cidade, :estado, :cep, :_destroy]
  )
end

end
