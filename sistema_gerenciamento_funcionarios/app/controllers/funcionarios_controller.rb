class FuncionariosController < ApplicationController
  before_action :set_funcionario, only: %i[show edit update destroy]
  before_action :set_departamentos_e_cargos, only: %i[new create edit update]


  # GET /funcionarios
  def index
    # Obter todos os funcionários
    @funcionarios = Funcionario.all

    # Obter os departamentos associados ao usuário logado
    if current_user.admin?
      @departamentos = Departamento.all
    else
      @departamentos = current_user.departamentos
    end

    # Filtro por nome do funcionário
    @funcionarios = @funcionarios.where('nome_completo LIKE ?', "%#{params[:nome]}%") if params[:nome].present?

    # Filtro por departamento, apenas os departamentos aos quais o usuário tem acesso
    if params[:departamento_id].present?
      departamento_id = params[:departamento_id].to_i
      @funcionarios = @funcionarios.joins(cargo: :departamento).where('departamentos.id = ?', departamento_id)
    else
      # Mostrar funcionários apenas dos departamentos associados ao usuário
      @funcionarios = @funcionarios.joins(cargo: :departamento).where(departamentos: { id: @departamentos.pluck(:id) })
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

  # GET /funcionarios/1
  def show
  end

  # GET /funcionarios/new
  def new
    @funcionario = Funcionario.new
    @funcionario.enderecos.build # Adiciona um endereço vazio para o formulário
  end

  # POST /funcionarios
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
  def update
    if @funcionario.update(funcionario_params)
      redirect_to @funcionario, notice: 'Funcionário atualizado com sucesso.'
    else
      render :edit
    end
  end

  # DELETE /funcionarios/1
  def destroy
    @funcionario.destroy
    redirect_to funcionarios_url, notice: 'Funcionário excluído com sucesso.'
  end

  private

  def set_departamentos_e_cargos
    if current_user.admin?
      @departamentos = Departamento.all
      @cargos = Cargo.all
    else
      # Filtra departamentos e cargos de acordo com o usuário
      @departamentos = current_user.departamentos
      @cargos = Cargo.where(departamento_id: @departamentos.pluck(:id))
    end
  end

  # Define o funcionário com base no id
  def set_funcionario
    @funcionario = Funcionario.find(params[:id])
  end

  # Permite parâmetros confiáveis
  def funcionario_params
    params.require(:funcionario).permit(
      :nome_completo, :cpf, :email, :data_nascimento, :data_contratacao, :salario, :status, :cargo_id,
      :genero, :rg, :telefone, 
      enderecos_attributes: [:id, :rua, :numero, :bairro, :cidade, :estado, :cep, :_destroy]
    )
  end
end
