require "test_helper"

class ClienteTest < ActiveSupport::TestCase

  def cliente
    @cliente ||= Cliente.new nome: "Giovani Paulino", email: 'j@j.com.br', password: Devise::Encryptor.digest(Cliente, 'password')
  end

  def test_valid
    assert cliente.valid?, "Erro no modelo Cliente: "+errors
  end

  def test_sem_nome
  	cliente.nome = nil
  	refute cliente.valid?
  end

  def test_tamanho_nome
  	cliente.nome = "Abcdefghi"
  	refute cliente.valid?
  end

  private
  def errors
  	erro = ""
  	if cliente.errors.any? 
  		cliente.errors.full_messages.each do |message|
  			erro = erro + message + "|"
  		end
  	end
  	erro
  end

end
