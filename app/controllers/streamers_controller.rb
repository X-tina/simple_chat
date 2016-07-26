class StreamersController < ApplicationController
  def index
    @objects = S3.bucket('self-streaming').objects
  end
end
