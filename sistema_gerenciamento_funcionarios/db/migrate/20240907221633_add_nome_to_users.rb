class AddNomeToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :nome, :string
  end
end
