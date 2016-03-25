require "test_helper"

class MovimentacoesControllerTest < ActionController::TestCase

  setup do
    @movimentacao ||= movimentacoes(:mov_one)


    @create = { :tipo => 'T',
                          :valor => 1,
                          :conta_dest_id => @movimentacao.conta_dest.codigo,
                          :conta_orig_id => @movimentacao.conta_orig.codigo}
  end

=begin
  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:movimentacoes)
  end
=end

  def test_new
    get :new, :cliente_id => Conta.find(@movimentacao.conta_dest_id).cliente_id, :conta_id => @movimentacao.conta_dest_id
    assert_response :success
  end

  def test_create
    assert_difference('Movimentacao.count') do
      post :create, movimentacao: @create, :cliente_id => Conta.find(@movimentacao.conta_dest_id).cliente_id, :conta_id => @movimentacao.conta_dest_id
    end
    assert_response :redirect
  end

  def test_show
    get :show, id: @movimentacao.to_param, :cliente_id => Conta.find(@movimentacao.conta_dest_id).cliente_id, :conta_id => @movimentacao.conta_dest_id
    assert_response :success
  end


  def test_edit
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
    assert_difference('Movimentacao.count', -1) do
      @conta = Conta.find(@movimentacao.conta_dest_id)
      delete :destroy, id: @movimentacao.to_param, :cliente_id => @conta.cliente_id, :conta_id => @movimentacao.conta_dest_id
    end

    assert_redirected_to cliente_conta_path(@conta.cliente_id, @conta.id)
  end
end
