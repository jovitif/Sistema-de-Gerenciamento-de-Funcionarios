class CreateUserDepartamentos < ActiveRecord::Migration[7.2]
  def change
    create_table :user_departamentos do |t|
      t.references :user, null: false, foreign_key: true
      t.references :departamento, null: false, foreign_key: true

      t.timestamps
    end
  end
end
