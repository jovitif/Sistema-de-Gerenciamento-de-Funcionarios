class Funcionario < ApplicationRecord
  has_many :enderecos, dependent: :destroy
  accepts_nested_attributes_for :enderecos, allow_destroy: true
  belongs_to :cargo
  has_one :departamento, through: :cargo  
  validates :nome_completo, :cpf, :email, :data_nascimento, :data_contratacao, presence: true
  validates :cpf, uniqueness: true
  validates :email, uniqueness: true
  validates :salario, numericality: { greater_than_or_equal_to: 0 }
  
  enum status: { ativo: 'Ativo', inativo: 'Inativo', em_licenca: 'Em licença' }
end
