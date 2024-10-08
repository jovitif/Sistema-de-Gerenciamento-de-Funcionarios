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

ActiveRecord::Schema[7.2].define(version: 2024_09_10_111704) do
  create_table "cargos", force: :cascade do |t|
    t.string "nome"
    t.text "descricao"
    t.integer "departamento_id", null: false
    t.integer "nivel"
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
    t.integer "cargo_id", null: false
    t.date "data_contratacao"
    t.decimal "salario"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cargo_id"], name: "index_funcionarios_on_cargo_id"
  end

  create_table "user_departamentos", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "departamento_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["departamento_id"], name: "index_user_departamentos_on_departamento_id"
    t.index ["user_id"], name: "index_user_departamentos_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "nome"
    t.string "role"
    t.boolean "force_password_change", default: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "cargos", "departamentos"
  add_foreign_key "enderecos", "funcionarios"
  add_foreign_key "funcionarios", "cargos"
  add_foreign_key "user_departamentos", "departamentos"
  add_foreign_key "user_departamentos", "users"
end
