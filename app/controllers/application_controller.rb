class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
 
  protect_from_forgery with: :null_session, if: :request_json?
  skip_before_filter :verify_authenticity_token, if: :request_json?

  acts_as_token_authentication_handler_for User, if: :request_json?
  respond_to :html, :json

  before_filter :authenticate_user!

  def request_json?
    request.format == 'application/json'
  end
end
