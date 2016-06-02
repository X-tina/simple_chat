class RoomsController < ApplicationController
  def show
    @messages = Message.all
    @users = User.try(:all_who_are_in_touch)
  end
end
