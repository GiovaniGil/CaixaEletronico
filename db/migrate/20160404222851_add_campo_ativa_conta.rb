class AddCampoAtivaConta < ActiveRecord::Migration
  def self.up
    change_table(:contas) do |t|
        t.boolean :ativa, default: true
      end
  end
end
