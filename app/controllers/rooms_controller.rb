class RoomsController < ApplicationController
  def show
  	@messages = Message.all
  	@users = User.all_who_are_in_touch
  end
end
