require "test_helper"

class SaldoControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  include Warden::Test::Helpers
  Warden.test_mode!

  setup do
    @conta ||= contas(:conta_one)
  end

  def test_show
    authenticate(Cliente.find(@conta.cliente_id))
    get :show, cliente_id: @conta.cliente_id, conta_id: @conta.id
    assert_response :success
  end

end
