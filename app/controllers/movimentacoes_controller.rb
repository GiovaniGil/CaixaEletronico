class MovimentacoesController < ApplicationController
  before_action :set_movimentacao, only: [:show, :edit, :update, :destroy]

  # GET /movimentacoes
  # GET /movimentacoes.json
=begin
  def index
    @movimentacoes = Movimentacao.all
  end
=end

  # GET /movimentacoes/1
  def show
    if @movimentacao.tipo != 'D'
      @conta = Conta.find(params[:conta_id])
      @cliente = Cliente.find(@conta.cliente_id)
    end
    #redirect_to cliente_conta_movimentacao_path(@cliente, @conta, @movimentacao)
  end

  # GET /movimentacoes/new
  def new

    if params[:tipo] != 'D'
      @contas = Conta.joins(:cliente)
      @conta = Conta.find(params[:conta_id])
      @cliente = Cliente.find(@conta.cliente_id)
    end
    @movimentacao = Movimentacao.new

    if !params[:tipo].nil?
      @movimentacao.tipo = params[:tipo]
    end
    #render new_cliente_conta_movimentacao_path(@cliente, @conta)
  end

  # GET /movimentacoes/1/edit
  def edit
    @conta = Conta.find(params[:conta_id])
    @cliente = Cliente.find(@conta.cliente_id)
    #redirect_to edit_cliente_conta_movimentacao_path(@cliente, @conta, @movimentacao)
  end

  # POST /movimentacoes
  def create

    @movimentacao = Movimentacao.new movimentacao_params

    if !@movimentacao.conta_dest_id.nil?
      if Conta.exists?(codigo: @movimentacao.conta_dest_id)
        @conta_dest = Conta.find_by_codigo(@movimentacao.conta_dest_id)
        @movimentacao.conta_dest_id = @conta_dest.id
      else
        flash[:error] = 'Conta inexistente'
        redirect_to new_movimentacao_path(@movimentacao, :tipo => @movimentacao.tipo), :action => :new
        return
      end
    end
    if !@movimentacao.conta_orig_id.nil?
      @conta_orig = Conta.find_by_codigo(@movimentacao.conta_orig_id)
      @movimentacao.conta_orig_id = @conta_orig.id
    end

    @cliente = Cliente.find(@conta_dest.cliente_id)

    if @movimentacao.save
      if ['T', 'S'].include? @movimentacao.tipo
        redirect_to cliente_conta_movimentacao_path(@cliente.id, @conta_orig.id, @movimentacao.id), notice: 'Movimentacao criada.'
      else
        redirect_to movimentacao_path(@movimentacao)
      end
    else
      flash[:error] = errors(@movimentacao)
      render :new
    end
  end

  # PATCH/PUT /movimentacoes/1
  def update
    @conta = Conta.find(params[:conta_id])
    @cliente = Cliente.find(@conta.cliente_id)

    if @movimentacao.update(movimentacao_params)
      redirect_to cliente_conta_movimentacao_path(@cliente, @conta, @movimentacao), notice: 'Movimentacao was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /movimentacoes/1
  def destroy
    @conta = Conta.find(params[:conta_id])
    @cliente = Cliente.find(@conta.cliente_id)
    @movimentacao.destroy
    flash[:notice] = 'Não é possível excluir movimentações.'
    redirect_to cliente_conta_path(@cliente, @conta)
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_movimentacao
    @movimentacao = Movimentacao.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def movimentacao_params
    params.require(:movimentacao).permit(:tipo, :valor, :conta_orig_id, :conta_dest_id)
  end

  def errors(model)
    erro = ""
    if model.errors.any?
      model.errors.full_messages.each do |message|
        erro = erro + message + "|"
      end
    end
    erro
  end

end
