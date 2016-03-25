require "test_helper"

class ClientesControllerTest < ActionController::TestCase

	setup do
		@cliente = clientes(:cliente_um)
	end

	def test_index
		get :index
		assert_response :success
	end

	def test_new
		get :new
		assert_response :success	
		assert_select 'form'	
	end

	def test_edit
		get :edit, id: @cliente
		assert_response :success
		assert_select 'form'
	end

	def test_show
		get :show, id: @cliente
		assert_response :success
	end

	def test_create
		assert_difference 'Cliente.count' do
			post :create, cliente: {nome: 'Tiradentes'}
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
		assert_difference('Cliente.count', -1) do
			delete :destroy, id: @cliente
		end
		assert_redirected_to clientes_path
	end

end
