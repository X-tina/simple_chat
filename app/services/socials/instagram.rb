class Socials::Instagram
  attr_accessor :user
  TEMP_EMAIL_PREFIX = User::TEMP_EMAIL_PREFIX

  def initialize(instagram_response_code=nil)
    @instagram_response_code = instagram_response_code
  end

  # Get user from Instagram by API and access_token
  def create_user_by_token
    @inst_response = get_instagram_data(:response)
    @user_hash = @inst_response.user
    
    identity = Identity.where(provider: 'instagram', uid: @user_hash.id).first_or_create do |identity|
      identity.provider_token = @response.access_token
    end
    @user = identity.user

    unless @user
      email = @user_hash.email
      @user = User.new(
               first_name: @user_hash.username,
               last_name: @user_hash.last_name || @user_hash.full_name,
               email: "#{TEMP_EMAIL_PREFIX}-#{@user_hash.id}-instagram.com",
               password: Devise.friendly_token[0,20]
             )
      @user.save!
      @user.identities << identity
    end

    @user
  end

  # get user from Instagram by callback
  def create_user_by_callback(signed_in_resource=nil)
    @inst_response = get_instagram_data(:response)
    @user_hash = @inst_response.user

    identity = Identity.find_for_oauth_instagram(@inst_response)
    user = signed_in_resource ? signed_in_resource : identity.user
    
    #Create the user if it's a new registration
    unless user
      user = User.new(
               first_name: @user_hash.username,
               last_name: @user_hash.last_name || @user_hash.full_name,
               email: "#{TEMP_EMAIL_PREFIX}-#{@user_hash.id}-instagram.com",
               password: Devise.friendly_token[0,20]
             )
      user.save!
      user.identities << identity
    end

    user
  end

  private

  def get_instagram_data(value)
    case value
      when :response
        Instagram.get_access_token(@instagram_response_code, redirect_uri: ENV['CALLBACK_URL'])
      when :client
        Instagram.client(:access_token => @response.access_token)
      end
  end
end