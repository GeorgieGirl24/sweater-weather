class MunchiesFacade
  def self.get_restaurants(munchies_params)
    origin = munchies_params[:start]
    destination = munchies_params[:end]
    term = munchies_params[:food]
    restaurants = MunchiesService.get_restaurants(destination, term)
    # binding.pry
    restaurant = Restaurant.new(restaurants)
    trip = MapFacade.get_trip(origin, destination)
    destination_weather = ForecastFacade.get_forecast_weather(destination)
  end
end
