class Cliente < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
				 :registerable,
         :recoverable,
				 :rememberable,
				 :trackable,
				 :validatable
	has_many :contas
	validates :nome, 
				presence: true, 
				length: {minimum: 10}
end
