class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
 
  protect_from_forgery with: :null_session, if: :request_json?
  skip_before_filter :verify_authenticity_token, if: :request_json?

  acts_as_token_authentication_handler_for User, only: [:create, :update, :destroy]

  before_action :set_online
  before_action :configure_permitted_parameters, if: :devise_controller?

  respond_to :html, :json

  def request_json?
    request.format == 'application/json'
  end

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:account_update,
          keys: [:first_name, :last_name, :latitude, :longitude, :email]
        )
    end


  private
    def set_online
      if !!current_user
        # не нужно значение, нужен только ключ
        # `ex: 10*60` - устанавливаем время жизни ключа - 10 минут, через 10 мину ключ удалиться
        $redis_onlines.set(current_user.id, nil, ex: 10*60)
      end
    end
end
