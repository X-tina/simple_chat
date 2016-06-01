class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
 
  protect_from_forgery with: :null_session, if: :request_json?
  skip_before_filter :verify_authenticity_token, if: :request_json?

  acts_as_token_authentication_handler_for User, if: :request_json?
  respond_to :html, :json

  before_action :authenticate_user!
  before_action :set_online

  def request_json?
    request.format == 'application/json'
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
