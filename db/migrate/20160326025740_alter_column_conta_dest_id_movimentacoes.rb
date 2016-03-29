class AlterColumnContaDestIdMovimentacoes < ActiveRecord::Migration
  def change
    change_column_null(:movimentacoes, :conta_dest_id, true )
  end
end
