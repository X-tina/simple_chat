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

  private

    def auth_hash
      request.env["omniauth.auth"]
    end

end