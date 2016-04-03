class ExtratoController < ApplicationController
  before_action :authenticate_cliente!

  def show
    @cliente = Cliente.find(params[:cliente_id])
    @conta = Conta.find(params[:conta_id])
    @movimentacoes = nil
    if !params[:data_inicial].nil? && !params[:data_final].nil?
      @movimentacoes = Movimentacao.where('(conta_orig_id = ? or conta_dest_id = ?) and created_at between ? and ?',
                                          params[:conta_id],
                                          params[:conta_id],
                                          Date.civil(params[:data_inicial][:year].to_i, params[:data_inicial][:month].to_i, params[:data_inicial][:day].to_i),
                                          Date.civil(params[:data_final][:year].to_i, params[:data_final][:month].to_i, params[:data_final][:day].to_i)+1.day
      )
    end

    respond_to do |format|
      format.html
      format.js
    end

  end
end
