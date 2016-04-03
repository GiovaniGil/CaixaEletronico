class ClientesController < ApplicationController
	before_action :authenticate_cliente!, except: [:new, :create]
	before_filter :validate_user, only: [:show]

	def index
		redirect_to root_path
	end

	def edit
		@cliente = Cliente.find(params[:id])
	end

	def show
		@cliente = Cliente.find(params[:id])
	end

	def new
		@cliente = Cliente.new
	end

	def create
		@cliente = Cliente.new cliente_params
		if @cliente.save
			flash[:notice] = 'Cliente criado!'
			redirect_to clientes_url
		else
			render :new
		end
	end

	def update
		@cliente = Cliente.find(params[:id])
		if @cliente.update(cliente_params)
			flash[:notice] = 'Cliente atualizada!'
			redirect_to cliente_path(@cliente)
		else
			flash[:error] = 'Conta não atualizada!'
			render :edit
		end
	end

	def destroy
		@cliente = Cliente.find(params[:id])
		@cliente.destroy
		flash[:success] = 'Cliente excluído.'
		redirect_to clientes_url
	end

	private
	def cliente_params
		params.require(:cliente).permit(:nome, :endereco, :telefone, :dataNascimento, :email, :password, :password_confirmation)
	end

	def validate_user
			unless current_cliente and current_cliente.id.to_s == params[:id]
			  reset_session
				redirect_to root_path
			end
	end
end
