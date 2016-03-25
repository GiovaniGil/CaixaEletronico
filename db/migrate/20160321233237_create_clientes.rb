class CreateClientes < ActiveRecord::Migration
  def change
    create_table :clientes do |t|
      t.string :nome
      t.string :endereco
      t.string :telefone
      t.date :dataNascimento

      t.timestamps
    end
  end
end
