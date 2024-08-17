class CreateDepartamentos < ActiveRecord::Migration[7.2]
  def change
    create_table :departamentos do |t|
      t.string :nome
      t.text :descricao
      t.string :codigo
      t.string :localizacao
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
