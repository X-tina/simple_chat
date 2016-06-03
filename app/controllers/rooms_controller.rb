class RoomsController < ApplicationController
  skip_before_filter :authenticate_user!
  
  def show
    @messages = Message.first(10)
  end
end
