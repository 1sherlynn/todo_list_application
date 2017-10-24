class User < ApplicationRecord
	has_many :tasks, dependent: :destroy#can use :dependent => delete_all(callbacks will not be executed) or destroy (more preferred)
	#e.g. dependent: :destroy


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable




  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
