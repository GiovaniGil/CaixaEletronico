class SaldoController < ApplicationController
  before_action :authenticate_cliente!

  def show
    @cliente = Cliente.find(params[:cliente_id])
    @conta = Conta.find(params[:conta_id])
    @movimentacoes = Movimentacao.where('conta_orig_id = ? or conta_dest_id = ?', params[:conta_id], params[:conta_id])

  end
end
