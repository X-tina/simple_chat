class MessagesController < ApplicationController
  skip_before_filter :authenticate_user!

  def index
    @messages = Message.page(params[:page]).per(10)
  end
end
