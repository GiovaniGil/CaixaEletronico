class AddCampoTaxaMovimentacoes < ActiveRecord::Migration
  def self.up
    change_table(:movimentacoes) do |t|
      t.float :taxa, null: false, default: 0
    end
  end
end
