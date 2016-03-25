class Conta < ActiveRecord::Base
  belongs_to :cliente
  has_many :origens, :class_name => 'Movimentacao', :foreign_key => 'conta_orig_id'
  has_many :destinos, :class_name => 'Movimentacao', :foreign_key => 'conta_dest_id'

  validates :codigo, presence: true,
            length: {is: 5}
  validates :cliente_id, presence: true
end
