class Actions::NearbyUsers
  RADIUS = 0.2 # 200 m convert to km

  def initialize(current_location)
    @location = current_location
  end

  def call
    User.near(@location, RADIUS, units: :km).order("distance")
  end
end