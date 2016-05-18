class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
       :recoverable, :rememberable, :trackable, :validatable,
       :timeoutable, :recoverable,
       :encryptable, :stretches => 30
end
