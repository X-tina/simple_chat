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

  scope :all_who_are_in_touch, ->(current_user_id=nil) do
    ids = $redis_onlines.keys
    ids.delete(current_user_id.to_s)
    self.where(id: ids)
  end

  def self.count_time
    p Time.now
  end

  def online?
    $redis_onlines.exist(self.id)
  end

  def self.except_current_user(current_user_id)
    self.where.not(id: current_user_id)
  end
end
