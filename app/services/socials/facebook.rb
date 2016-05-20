class Socials::Facebook
  attr_accessor :user

  def initialize(oauth_access_token=nil)
    @oauth_access_token = oauth_access_token
  end

  # Get user from Facebook by API and access_token
  def create_user_by_token
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
      @user.identities << identity
    end

    @user
  end

  # get user from Facebook by callback
  def create_user_by_callback(auth_hash, signed_in_resource=nil)
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

  private

    def get_facebook_data
      @graph = Koala::Facebook::API.new(@oauth_access_token)
      @user_hash = @graph.get_object("me?fields=id,first_name,last_name,email")
    end
end