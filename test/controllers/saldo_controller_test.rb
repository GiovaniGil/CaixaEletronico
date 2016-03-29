require "test_helper"

class SaldoControllerTest < ActionController::TestCase
  def test_show
    get :show
    assert_response :success
  end

end
