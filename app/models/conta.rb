class Conta < ActiveRecord::Base
  belongs_to :cliente
  has_many :origens, :class_name => 'Movimentacao', :foreign_key => 'conta_orig_id'
  has_many :destinos, :class_name => 'Movimentacao', :foreign_key => 'conta_dest_id'

  validates :codigo, presence: true,
            length: {is: 5}, uniqueness: true, numericality: { only_integer: true }
  validates :cliente_id, presence: true


  def saldo
    saldo = 0
    movimentacoes = (self.origens << self.destinos).sort{|a,b| a.created_at <=> b.created_at }

    movimentacoes.each do |movimentacao|
      if  (['S', 'T'].include? movimentacao.tipo)
        saldo -= movimentacao.valor
      end
      if movimentacao.tipo == 'D'
        saldo += movimentacao.valor
      end
    end
    saldo
  end

  def saldo_parcial(movimentacoes)
    saldo = 0

    movimentacoes.each do |movimentacao|
      if  (['S', 'T'].include? movimentacao.tipo)
        saldo -= movimentacao.valor
      end
      if movimentacao.tipo == 'D'
        saldo += movimentacao.valor
      end
    end
    saldo
  end
end
