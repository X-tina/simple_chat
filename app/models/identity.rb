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
end
