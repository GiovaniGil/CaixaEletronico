class Movimentacao < ActiveRecord::Base
  after_save :calcular_taxa!

  validates_numericality_of :valor, presence: true,  on: :create, message: 'Valor deve ser um número', greater_than: 0
  validates :conta_dest_id, presence: true, if: :tipo_desposito_transferencia?
  validates :conta_orig_id, presence: true, if: :tipo_saque_transferencia?

  belongs_to :conta_orig, :class_name => 'Conta', :foreign_key => 'conta_orig_id'
  belongs_to :conta_dest, :class_name => 'Conta', :foreign_key => 'conta_dest_id'

  def tipo_desposito_transferencia?
    ['D', 'T'].include? self.tipo
  end

  def tipo_saque_transferencia?
    ['S', 'T'].include? self.tipo
  end

  def calcular_taxa!
    taxa = 0.0
    if !self.created_at.saturday? && !self.created_at.sunday?
      if self.created_at.hour.between?(9,18)
        taxa = 5.0
      else
        taxa = 7.0
      end
      if self.valor > 1000
        taxa += 10
      end
    end
    self.taxa = taxa
  end

end
