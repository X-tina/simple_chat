class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:index, :edit, :update]
  skip_before_filter :authenticate_user!, only: [:nearby_users, :nearby_guests]

  def index
    @users = User.try(:all_who_are_in_touch)
  end

  def show;  end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render 'user', locals: { resource: @user } }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def nearby_users
    if current_user

      @user = current_user
      @current_location = [@user.latitude, @user.longitude]
      @users = Actions::NearbyUsers.new(@current_location).call.all_who_are_in_touch(@user.try(:id))

      respond_to do |format|
        format.html
        format.json { render index }
      end
    else
      @current_location = [params[:latitude], params[:longitude]]
      render 'errors/error.json.rabl'
    end
  end

  def nearby_guests
    id = Random.new_seed.to_s
    if user_params[:guest]
      # $redis_location.hmset(id, :latitude, user_params[:latitude], :longitude, user_params[:longitude] )
      # p $redis_location.hgetall(id)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :latitude, :longitude, :guest)
    end

    def set_guest_params
      hash = {}
      hash['position'] = { 'latitude' => user_params[:latitude], 'longitude' => user_params[:longitude] }
    end
end
