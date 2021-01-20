class MunchiesFacade
  def self.get_restaurants(munchies_params)
    origin = munchies_params[:origin]
    destination = munchies_params[:destination]
    term = munchies_params[:food]
    restaurants = MunchiesService.get_restaurants(destination, term)
    restaurant = Restaurant.new(restaurants)
    roadtrip = RoadTripFacade.get_trip(munchies_params)
    Munchie.new(restaurant, roadtrip)
  end
end
