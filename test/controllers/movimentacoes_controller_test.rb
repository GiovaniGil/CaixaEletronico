require "test_helper"

class MovimentacoesControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  include Warden::Test::Helpers
  Warden.test_mode!

  setup do
    @movimentacao ||= movimentacoes(:mov_one)

    @movimentacaoSaque = Movimentacao.new :tipo => 'S',
                :valor => 1,
                :conta_orig_id => @movimentacao.conta_orig.codigo,
                :conta_dest_id => nil

    @movimentacaoTransf = Movimentacao.new :tipo => 'T',
                                          :valor => 1,
                                          :conta_orig_id => @movimentacao.conta_orig.codigo,
                                          :conta_dest_id => @movimentacao.conta_dest.codigo

    @contaOrig = Conta.find_by_codigo(@movimentacao.conta_orig.codigo)
    @contaDest = Conta.find_by_codigo(@movimentacao.conta_dest.codigo)
  end

=begin
  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:movimentacoes)
  end
=end

  def test_new

    @cliente = Cliente.find(@contaOrig.cliente_id)
    authenticate(@cliente)

    get :new, :cliente_id => @cliente.id, :conta_id => @contaOrig.id,  :tipo => 'S'
    assert_response :success
  end


  def test_new_2
    get :new, :tipo => 'D'
    assert_response :success
  end

  def test_create_saque
    authenticate(Cliente.find(@contaOrig.cliente_id))

    assert_difference('Movimentacao.count') do
      post :create, movimentacao: @movimentacaoSaque.attributes,
           :cliente_id => @contaOrig.cliente_id,
           :conta_id => @contaOrig.id
    end
    assert_response :redirect
  end

  def test_create_transferencia
    authenticate(Cliente.find(@contaOrig.cliente_id))

    assert_difference('Movimentacao.count') do
      post :create, movimentacao: @movimentacaoTransf.attributes,
           :cliente_id => @contaOrig.cliente_id,
           :conta_id => @contaOrig.id
    end
    assert_response :redirect
  end

  def test_show
    get :show, id: @movimentacao.to_param, :cliente_id => Conta.find(@movimentacao.conta_dest_id).cliente_id, :conta_id => @movimentacao.conta_dest_id
    assert_response :success
  end


  def test_edit
    authenticate(Cliente.find(@contaOrig.cliente_id))
    get :edit, id: @movimentacao.to_param, :cliente_id => Conta.find(@movimentacao.conta_dest_id).cliente_id, :conta_id => @movimentacao.conta_dest_id
    assert_response :success
  end


  def test_update
    put :update, id: @movimentacao.id, movimentacao: { tipo: 'D'},
        :conta_id => @movimentacao.conta_dest_id,
        :cliente_id =>  Conta.find(@movimentacao.conta_dest_id).id
    assert :redirect
  end


  def test_destroy
    authenticate(Cliente.find(@contaOrig.cliente_id))
    assert_difference('Movimentacao.count', 0) do
      delete :destroy, id: @movimentacao.to_param, :cliente_id => @contaOrig.cliente_id, :conta_id => @contaOrig.id
    end
    assert_redirected_to cliente_conta_path(@contaOrig.cliente_id, @contaOrig)
  end
end
