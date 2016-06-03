class RoomsController < ApplicationController
  def show
    @messages = Message.first(10)
    @users = User.try(:all_who_are_in_touch)
  end
end
