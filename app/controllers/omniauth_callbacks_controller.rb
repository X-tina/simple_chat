class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def self.provides_callback_for(provider)
    class_eval %Q{
      def #{provider}
        @user = User.find_for_oauth(auth_hash, current_user)

        if @user.persisted?
          if request_json?
            @uid = Idintity.find_by(user_id: @user.id).uid
          else
            sign_in_and_redirect @user, event: :authentication
          end

          set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?

        else
          session["devise.#{provider}_data"] = auth_hash

          redirect_to new_user_registration_path
        end
      end
    }
  end

  [:facebook].each { |provider| provides_callback_for(provider) }

  # Make POST request to: h/omniauth_callbacks/facebook with params: {"user": {"oauth_token": "......"} }
  def facebook_auth
    facebook_data = Socials::Facebook.new(user_oauth_params[:oauth_token])
    @user = facebook_data.create_user
  
    render json: { meta: { message: 'successfull sign in via Facebook' },
                   data: { authentication_token: @user.authentication_token,
                           email: @user.email } }
    rescue Koala::Facebook::AuthenticationError
      render json: { errors: 'wrong token' }
    rescue ActiveRecord::RecordInvalid => e
      render json: { errors: e.message }
  end


  private

    def auth_hash
      request.env["omniauth.auth"]
    end

    def user_oauth_params
      params.fetch(:user, {})
    end

end
