class User < ActiveRecord::Base
  acts_as_token_authenticatable
  geocoded_by :full_street_address
  
  devise :database_authenticatable, :registerable,
       :recoverable, :rememberable, :trackable, :validatable,
       :recoverable, :omniauthable,
       :timeoutable,
       :encryptable, :stretches => 30,
       :omniauth_providers => [:facebook]
  
  has_many :identities, dependent: :destroy

  def self.count_time
    p Time.now
  end

  def online?
    $redis_onlines.exist(self.id)
  end

  def self.all_who_are_in_touch
    ids = $redis_onlines.keys
    self.find(ids)
  end
end
