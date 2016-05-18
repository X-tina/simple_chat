class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :rememberable, :trackable, :validatable,
  #        :timeoutable, :recoverable, stretches: 20

  devise :database_authenticatable, :registerable,
       :recoverable, :rememberable, :trackable, :validatable,
       :encryptable, :stretches => 30
end
