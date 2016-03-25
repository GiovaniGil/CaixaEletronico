class CreateContas < ActiveRecord::Migration
  def change
    create_table :contas do |t|
      t.string :descricao
      t.string :codigo
      t.integer :cliente_id

      t.timestamps
    end
  end
end
