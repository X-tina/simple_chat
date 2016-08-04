class Socials::Instagram
  attr_accessor :user
  TEMP_EMAIL_PREFIX = User::TEMP_EMAIL_PREFIX

  def initialize(instagram_response_code=nil, instagram_access_token=nil)
    @instagram_response_code = instagram_response_code
    @instagram_access_token = instagram_access_token
  end

  # Get user from Instagram by API and access_token
  def create_user_by_token
    @inst_response = get_instagram_data(:client)
    @user_hash = @inst_response.user

    @identity = Identity.find_for_oauth_instagram(@inst_response)
    @user = @identity.user

    create_user unless user
  end

  # get user from Instagram by callback
  def create_user_by_callback(signed_in_resource=nil)
    @inst_response = get_instagram_data(:response)
    @user_hash = @inst_response.user

    @identity = Identity.find_for_oauth_instagram(@inst_response)
    user = signed_in_resource ? signed_in_resource : @identity.user

    #Create the user if it's a new registration
    create_user unless user
  end

  private

  def get_instagram_data(value)
    case value
      when :response
        Instagram.get_access_token(@instagram_response_code, redirect_uri: ENV['CALLBACK_URL'])
      when :client
        Instagram.client(:access_token => @instagram_access_token)
      end
  end

  def create_user
    user = User.new(
             first_name: @user_hash.username,
             last_name: @user_hash.last_name || @user_hash.full_name,
             email: "#{TEMP_EMAIL_PREFIX}-#{@user_hash.id}-instagram.com",
             password: Devise.friendly_token[0,20]
           )
    user.save!
    user.identities << @identity

    user
  end
end
