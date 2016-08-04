class Identity < ActiveRecord::Base
  belongs_to :user

  validates :uid, :provider, presence: true
  validates_uniqueness_of :uid, scope: :provider

  def self.find_for_oauth(auth_hash)
    where(uid: auth_hash.uid, provider: auth_hash.provider).first_or_create do |identity|
      identity.provider_token = auth_hash.credentials.try(:token)
      # identity.image_url = auth_hash.info.image
    end
  end

  def self.find_for_oauth_instagram(inst_response)
  	where(uid: inst_response.user.id, provider: 'instagram').first_or_create do |identity|
  		identity.provider_token = inst_response.access_token
  	end
  end
end
