class ExtratoController < ApplicationController
  before_action :authenticate_cliente!
  def show
    @cliente = Cliente.find(params[:cliente_id])
    @conta = Conta.find(params[:conta_id])
    @movimentacoes = nil
    if !params[:data_incial].nil? && !params[:data_final].nil?
      @movimentacoes = Movimentacao.where('(conta_orig_id = ? or conta_dest_id = ?) and created_at between ? and ?',
                                          params[:conta_id],
                                          params[:conta_id],
                                          Date.parse(params[:data_incial]),
                                          Date.parse(params[:data_final])+1.day )
    end

    respond_to do |format|
      format.html
      format.js
    end

  end
end
