require "test_helper"

class ContasControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  include Warden::Test::Helpers
  Warden.test_mode!

  setup do
    @conta ||= contas(:conta_one)
  end

  def test_index
    authenticate(Cliente.find(@conta.cliente_id))
    get :index, :cliente_id => @conta.cliente_id
    assert_response :success
  end

  def test_new
    authenticate(Cliente.find(@conta.cliente_id))
    get :new, :cliente_id => @conta.cliente_id
    assert_response :success
  end

  def test_create
    authenticate(Cliente.find(@conta.cliente_id))
    post :create, conta: {codigo:"12345" }, :cliente_id => @conta.cliente_id
    assert_response :success
  end

  def test_show
    authenticate(Cliente.find(@conta.cliente_id))
    get :show, id: @conta.to_param, :cliente_id => @conta.cliente_id
    assert_response :success
  end

  def test_edit
    authenticate(Cliente.find(@conta.cliente_id))
    get :edit, id: @conta.to_param, :cliente_id => @conta.cliente_id
    assert_response :success
  end

  def test_update
    authenticate(Cliente.find(@conta.cliente_id))
    put :update, :id => @conta.to_param, :conta => @conta.attributes, :cliente_id => @conta.cliente_id
    assert_redirected_to cliente_conta_path(@conta.cliente_id, @conta.id)
  end

  def test_destroy
    authenticate(Cliente.find(@conta.cliente_id))
    assert_difference('Conta.count', 0) do
      delete :destroy, :id => @conta.to_param, :cliente_id => @conta.cliente_id
    end
    assert_equal 'Conta desativada!', flash[:notice]
  end
end
