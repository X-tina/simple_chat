class DeviseLib::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def self.provides_callback_for(provider)
    class_eval %Q{
      def #{provider}
        case "#{provider}"
          when "facebook"
            facebook_init = Socials::Facebook.new
            @user = facebook_init.create_user_by_callback(auth_hash, current_user)
          when "instagram"
            instagram_init = Socials::Instagram.new(params[:code])
            @user = instagram_init.create_user_by_callback
          end

        if @user.persisted?
          if request_json?
            @uid = Idintity.find_by(user_id: @user.id).uid
          else
            sign_in_and_redirect @user, event: :authentication
          end

          set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?

        else
          session["devise.#{provider}_data"] = auth_hash if auth_hash

          redirect_to new_user_registration_path
        end
      end
    }
  end

  [:facebook, :instagram].each { |provider| provides_callback_for(provider) }

  # Make POST request to: h/omniauth_callbacks/facebook with params: {"user": {"oauth_token": "......"} }
  def facebook_auth_by_token
    facebook_data = Socials::Facebook.new(user_oauth_params[:oauth_token])
    @user = facebook_data.create_user_by_token

    render_json('successfull sign in via Facebook')
    rescue Koala::Facebook::AuthenticationError
      render json: { errors: 'wrong token' }
    rescue ActiveRecord::RecordInvalid => e
      render json: { errors: e.message }
  end

  # Make POST request to: h/omniauth_callbacks/instagram with params: {"user": {"access_token": "....."} }
  def instagram_auth_by_token
    instagram_data = Socials::Instagram.new(nil,user_oauth_params[:access_token])
    @user = instagram_data.create_user_by_token
    
    render_json('successfull sign in via Instagram')
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

    def render_json(messsage)
      render json: { meta: { message: messsage },
                   data: { authentication_token: @user.authentication_token,
                           email: @user.email,
                           first_name: @user.first_name,
                           last_name: @user.last_name
                         }
                   }
    end
end
