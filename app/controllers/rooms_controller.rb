class RoomsController < ApplicationController  
  def show
    @messages = Message.first(10)
  end
end
