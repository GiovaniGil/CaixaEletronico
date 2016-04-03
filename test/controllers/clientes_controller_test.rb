require "test_helper"

class ClientesControllerTest < ActionController::TestCase
	include Devise::TestHelpers
	include Warden::Test::Helpers
	Warden.test_mode!

	setup do
		@cliente = clientes(:cliente_um)
	end

	def test_index
		authenticate_cliente
		get :index
		assert_redirected_to root_path
	end

	def test_new
		get :new
		assert_response :success
		assert_select 'form'
	end

	def test_edit
		authenticate_cliente
		get :edit, id: @cliente.to_param
		assert_response :success
		assert_select 'form'
	end

	def test_show
		authenticate_cliente
		get :show, id: @cliente.to_param
		assert_response :success
	end

	def test_create
		assert_difference 'Cliente.count' do
			post :create, cliente: {nome: 'Giovani Paulino',
															email: 'piano@piano.com',
															password: '1234',
															password_confirmation: '1234'}
			puts assigns(:cliente).errors.inspect
		end
		assert_redirected_to clientes_url
		assert_equal 'Cliente criado!', flash[:notice]
	end

	def test_falha_criacao
		assert_no_difference 'Cliente.count' do
			post :create, cliente: {nome: ''}
		end
		assert_template 'new'
	end

	def test_excluir
		authenticate_cliente
		assert_difference('Cliente.count', -1) do
			delete :destroy, id: Cliente.first.id
		end
		assert_redirected_to clientes_path
	end

	private
	def authenticate_cliente
		sign_in(@cliente)
	end

end
