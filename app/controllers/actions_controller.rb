class ActionsController < ApplicationController
  def index
    @message = Message.find(action_params[:id])
    Actions::Like.new.call(@message, action_params[:action_param])
  end

  private

    def action_params
      params.permit(:id, :action_param)
    end
end
