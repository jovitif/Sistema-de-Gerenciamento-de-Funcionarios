class CreateFuncionarios < ActiveRecord::Migration[7.2]
  def change
    create_table :funcionarios do |t|
      t.string :nome_completo
      t.date :data_nascimento
      t.string :genero
      t.string :cpf
      t.string :rg
      t.string :telefone
      t.string :email
      t.references :cargo, null: false, foreign_key: true
      t.date :data_contratacao
      t.decimal :salario
      t.string :status

      t.timestamps
    end
  end
end
