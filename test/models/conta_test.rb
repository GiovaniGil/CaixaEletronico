require "test_helper"

class ContaTest < ActiveSupport::TestCase

  def conta
    @conta ||= Conta.new codigo:"88888", cliente_id: 1
  end

  def test_valid
    assert conta.valid?, "Erro no modelo Conta: "+errors
  end

  def test_sem_codigo
    conta.codigo = nil
    refute @conta.valid?
  end

  def test_tamanho_codigo
    conta.codigo = "1234"
    refute conta.valid?
  end

  private
  def errors
    erro = ""
    if conta.errors.any?
      conta.errors.full_messages.each do |message|
        erro = erro + message + "|"
      end
    end
    erro
  end

end
