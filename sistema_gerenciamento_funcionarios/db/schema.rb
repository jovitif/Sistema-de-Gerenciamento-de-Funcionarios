# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2024_08_17_120940) do
  create_table "cargos", force: :cascade do |t|
    t.string "nome"
    t.text "descricao"
    t.integer "departamento_id", null: false
    t.string "nivel"
    t.decimal "salario_base", precision: 10, scale: 2
    t.text "requisitos"
    t.text "beneficios"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["departamento_id"], name: "index_cargos_on_departamento_id"
  end

  create_table "departamentos", force: :cascade do |t|
    t.string "nome"
    t.text "descricao"
    t.string "codigo"
    t.string "localizacao"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "enderecos", force: :cascade do |t|
    t.string "rua"
    t.string "numero"
    t.string "complemento"
    t.string "bairro"
    t.string "cidade"
    t.string "estado"
    t.string "cep"
    t.integer "funcionario_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["funcionario_id"], name: "index_enderecos_on_funcionario_id"
  end

  create_table "funcionarios", force: :cascade do |t|
    t.string "nome_completo"
    t.date "data_nascimento"
    t.string "genero"
    t.string "cpf"
    t.string "rg"
    t.string "telefone"
    t.string "email"
    t.string "cargo"
    t.date "data_contratacao"
    t.decimal "salario"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "cargos", "departamentos"
  add_foreign_key "enderecos", "funcionarios"
end
