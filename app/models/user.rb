class User < ActiveRecord::Base
  acts_as_token_authenticatable
  
  devise :database_authenticatable, :registerable,
       :recoverable, :rememberable, :trackable, :validatable,
       :timeoutable, :recoverable, :omniauthable,
       :encryptable, :stretches => 30,
       :omniauth_providers => [:facebook]
  
  has_many :identities

  #For Facebook now
  def self.find_for_oauth(auth_hash, signed_in_resource = nil)
    identity = Identity.find_for_oauth(auth_hash)
    user = signed_in_resource ? signed_in_resource : identity.user

    if user.nil?
      email = auth_hash.info.email
      user = User.find_by(email: email) if email

      #Create the user if it's a new registration
      unless user
        user = User.new(
                 first_name: auth_hash.extra.raw_info.first_name,
                 last_name: auth_hash.extra.raw_info.last_name,
                 email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth_hash.uid}-#{auth_hash.provider}.com",
                 password: Devise.friendly_token[0,20]
               )
        user.save!
      end
    end

    #Associate the identity with user
    if identity.user != user
      identity.user = user
      identity.save!
    end

    user
  end
end
