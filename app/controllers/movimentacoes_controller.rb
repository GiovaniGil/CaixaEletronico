class MovimentacoesController < ApplicationController
  before_action :set_movimentacao, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_cliente!, except: [:new, :create, :show]

  # GET /movimentacoes
  # GET /movimentacoes.json

  def index
    redirect_to root_path
  end

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
    @movimentacao = Movimentacao.new
    if !(['T', 'S', 'D'].include?params[:tipo])
      flash[:error] = 'MOVIMENTAÇÃO NÃO PERMITIDA'
      redirect_to root_path
      return
    else
      !params[:tipo].nil?
      @movimentacao.tipo = params[:tipo]
    end

    if params[:tipo] != 'D'
      @contas = Conta.joins(:cliente)
      if !params[:conta_id].nil?
        @conta = Conta.find(params[:conta_id])
        @cliente = Cliente.find(params[:cliente_id])
      else
        flash[:error] = 'Conta não encontrada.'
        redirect_to root_path
        return
      end
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

    #verifica qual o tipo de transação - Quando for Transferencia - T a conta de origem é a conta seleciona previamente
    #sendo Debito - D não precisa de conta_orig
    #sendo Saque - S é necessário apenas conta de destino
    @movimentacao = Movimentacao.new movimentacao_params

    if @movimentacao.valor.nil? || @movimentacao.valor <= 0
      flash[:error] = 'Valor deve ser um número inteiro maior que 0.'
      if @movimentacao.tipo == 'D'
        redirect_to new_movimentacao_path(@movimentacao, :tipo => 'D')
      else
        redirect_to new_cliente_conta_movimentacao_path(params[:cliente_id], params[:conta_id], :tipo => @movimentacao.tipo)
      end
      return
    end

    @conta_destino = Conta.find_by_codigo(@movimentacao.conta_dest_id)
    if (['S','T'].include? @movimentacao.tipo)
      @conta_origem = Conta.find(params[:conta_id])
    else
      @conta_origem = Conta.find_by_codigo(@movimentacao.conta_orig_id)
    end

    if (['D','T'].include? @movimentacao.tipo)
      if !@conta_destino.nil?
        if @movimentacao.tipo == 'T'
          @movimentacao.conta_orig_id = @conta_origem.id
          @cliente = Cliente.find(params[:cliente_id])
        else
          @movimentacao.conta_orig_id = nil
          @cliente = Cliente.find(@conta_destino.cliente_id)
        end
      else
        flash[:error] = 'Conta de destino inexistente'
        redirect_to new_cliente_conta_movimentacao_path(params[:cliente_id], params[:conta_id], :tipo => @movimentacao.tipo)
        return
      end
    else
      @movimentacao = Movimentacao.new movimentacao_params
      @movimentacao.conta_orig_id = params[:conta_id]
      @conta_origem = Conta.find(@movimentacao.conta_orig_id)
      @cliente = Cliente.find(params[:cliente_id])
    end

    if (['S','T'].include?@movimentacao.tipo) && (@movimentacao.valor > @conta_origem.saldo)
      flash[:alert] = 'Valor da movimentação superior ao limite da conta. Ação cancelada.'
      redirect_to cliente_conta_path(@cliente.id, @movimentacao.conta_orig_id)
      return
    end

    if !@movimentacao.conta_dest_id.nil?
      if Conta.exists?(['codigo = ? and ativa = ?', @movimentacao.conta_dest_id, true])
        @conta_dest = Conta.find_by_codigo(@movimentacao.conta_dest_id)
        @movimentacao.conta_dest_id = @conta_dest.id
      else
        flash[:error] = 'Conta de destino inexistente'
        redirect_to new_movimentacao_path(@movimentacao, :tipo => 'D')
        return
      end
    end

    if @movimentacao.save
      if (['T', 'S'].include? @movimentacao.tipo)
        redirect_to cliente_conta_movimentacao_path(@cliente.id, @movimentacao.conta_orig_id, @movimentacao.id), notice: 'Movimentacao criada.'
        return
      else
        flash[:notice] = 'Movimentação realizada com sucesso!'
        redirect_to root_path(@movimentacao)
        return
      end
    else
      flash[:alert] = errors(@movimentacao)
      redirect_to cliente_conta_path(@cliente.id, @movimentacao.conta_orig_id)
      return
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
    flash[:notice] = 'Não é possível excluir movimentações.'
    redirect_to cliente_conta_path(@cliente, @conta)
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_movimentacao
    @movimentacao = Movimentacao.find(params[:id])
  end

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
