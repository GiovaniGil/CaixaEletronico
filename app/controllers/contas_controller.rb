class ContasController < ApplicationController
  before_action :authenticate_cliente!
  before_action :set_conta, only: [:show, :edit, :update, :destroy]

  # GET /contas
  def index
    @cliente = Cliente.find( params[:cliente_id])
    @contas = Conta.where(['cliente_id=? and ativa=?', params[:cliente_id], true])
  end

  # GET /contas/1
  def show
    @cliente = Cliente.find(params[:cliente_id])
    @conta = Conta.find(params[:id], :conditions => ["ativa=?", true])
  end

  # GET /contas/new
  def new
    @cliente = Cliente.find(params[:cliente_id])
    @conta = Conta.new
  end

  # GET /contas/1/edit
  def edit
    @cliente = Cliente.find(params[:cliente_id])
    @conta = Conta.find(params[:id], :conditions => ["ativa=?", true])
  end

  # POST /contas
  def create
    @cliente = Cliente.find(params[:cliente_id])
    @conta = Conta.new conta_params
    if @conta.save
      flash[:notice] = 'Conta criada!'
      redirect_to cliente_conta_path(@conta.cliente, @conta)
    else
      flash[:error] = 'Conta não criada!'
      render :new
    end
  end

  # PATCH/PUT /contas/1
  def update
    if @conta.update(conta_params)
      flash[:notice] = 'Conta atualizada!'
      redirect_to cliente_conta_path(@conta.cliente, @conta)
    else
      flash[:error] = 'Conta não atualizada!'
      render :edit
    end
  end

  # DELETE /contas/1
  def destroy
    @conta = Conta.find(params[:id])
    @conta.ativa = false
    if @conta.save
      flash[:notice] = 'Conta desativada!'
      redirect_to cliente_path(params[:cliente_id])
    else
      flash[:error] = 'Conta não pôde ser desativada!'
      redirect_to cliente_path(params[:cliente_id])
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_conta
    @conta = Conta.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def conta_params
    params.require(:conta).permit(:descricao, :codigo, :cliente_id)
  end

  def conta_update_params
    params.require(:conta).permit(:descricao)
  end
end
