class Movimentacao < ActiveRecord::Base
  validates_numericality_of :valor, presence: true,  on: :create, message: 'Valor deve ser um número', greater_than: 0

  validates :conta_dest_id, presence: true

  belongs_to :conta_orig, :class_name => 'Conta', :foreign_key => 'conta_orig_id'
  belongs_to :conta_dest, :class_name => 'Conta', :foreign_key => 'conta_dest_id'
end
