class RoomsController < ApplicationController
  skip_before_filter :authenticate_user!
  
  def show
    @messages = Message.first(10)
    @users = User.try(:all_who_are_in_touch)
  end
end
