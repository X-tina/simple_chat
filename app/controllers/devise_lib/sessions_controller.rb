class DeviseLib::SessionsController < Devise::SessionsController
	skip_before_filter :verify_authenticity_token, if: :request_json?
  respond_to :json
end
