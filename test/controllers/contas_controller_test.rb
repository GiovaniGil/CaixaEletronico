require "test_helper"

class ContasControllerTest < ActionController::TestCase

  setup do
    @conta ||= contas(:conta_one)
  end

  def test_index
    get :index, :cliente_id => @conta.cliente_id
    assert_response :success
  end

  def test_new
    get :new, :cliente_id => @conta.cliente_id
    assert_response :success
  end

  def test_create
    post :create, conta: {codigo:"12345" }, :cliente_id => @conta.cliente_id
    assert_response :success
  end

  def test_show
    get :show, id: @conta.to_param, :cliente_id => @conta.cliente_id
    assert_response :success
  end

  def test_edit
    get :edit, id: @conta.to_param, :cliente_id => @conta.cliente_id
    assert_response :success
  end

  def test_update
    put :update, :id => @conta.to_param, :conta => @conta.attributes, :cliente_id => @conta.cliente_id
    assert_redirected_to cliente_conta_path(@conta.cliente_id, @conta.id)
  end

  def test_destroy
    assert_difference('Conta.count', 0) do
      delete :destroy, :id => @conta.to_param, :cliente_id => @conta.cliente_id
    end
    assert_equal 'Não é possível excluir contas.', flash[:notice]
  end
end
