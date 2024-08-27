class Departamento < ApplicationRecord
    has_many :cargos
    enum status: { ativo: 0, inativo: 1 }
end
