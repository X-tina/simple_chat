class User < ActiveRecord::Base
  acts_as_token_authenticatable
  
  devise :database_authenticatable, :registerable,
       :recoverable, :rememberable, :trackable, :validatable,
       :timeoutable, :recoverable, :omniauthable,
       :encryptable, :stretches => 30,
       :omniauth_providers => [:facebook]
  
  has_many :identities, dependent: :destroy
end
