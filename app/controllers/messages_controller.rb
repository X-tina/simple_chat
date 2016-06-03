class MessagesController < ApplicationController
  def index
    @messages = Message.page(params[:page]).per(10)
  end
end
