class Socials::Facebook
  attr_accessor :user

  def initialize(oauth_access_token)
    @oauth_access_token = oauth_access_token
  end

  def create_user
    get_facebook_data
    identity = Identity.where(provider: 'facebook', uid: @user_hash['id']).first_or_create do |identity|
      identity.provider_token = @oauth_access_token
    end
    @user = identity.user

    unless @user
      email = @user_hash['email']
      @user = User.new(
               first_name: @user_hash['first_name'],
               last_name: @user_hash['last_name'],
               email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth_hash.uid}-#{auth_hash.provider}.com",
               password: Devise.friendly_token[0,20]
             )
      @user.save!
    end

    @user
  end

  private

    def get_facebook_data
      @graph = Koala::Facebook::API.new(@oauth_access_token)
      @user_hash = @graph.get_object("me?fields=id,first_name,last_name,email")
    end
end