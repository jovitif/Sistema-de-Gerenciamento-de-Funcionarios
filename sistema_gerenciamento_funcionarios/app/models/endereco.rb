class Endereco < ApplicationRecord
  belongs_to :funcionario
  validates :rua, :numero, :bairro, :cidade, :estado, :cep, presence: true
end
