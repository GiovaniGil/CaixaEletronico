require "test_helper"

class CaixaControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  include Warden::Test::Helpers
  Warden.test_mode!

  def test_index
    get :index
    assert_response :success
  end

end
