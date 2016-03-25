require "test_helper"

class MovimentacaoTest < ActiveSupport::TestCase

  def movimentacao
    @movimentacao ||= Movimentacao.new valor: 1, conta_dest_id: 1
  end

  def test_valid
    assert movimentacao.valid?, 'Erro no model Movimentacao: '+errors(movimentacao)
  end

  private
  def errors(model)
    erro = ""
    if model.errors.any?
      model.errors.full_messages.each do |message|
        erro = erro + message + "|"
      end
    end
    erro
  end

end
