class Cliente < ActiveRecord::Base
	has_many :contas
	validates :nome, 
				presence: true, 
				length: {minimum: 10}
end
