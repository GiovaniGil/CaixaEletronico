class CreateMovimentacoes < ActiveRecord::Migration
  def change
    create_table :movimentacoes do |t|
      t.string :tipo, :null => false, inclusion: ['D', 'S', 'T']
      t.float :valor
      t.integer :conta_orig_id
      t.integer :conta_dest_id, :null => false

      t.timestamps
    end
  end
end
