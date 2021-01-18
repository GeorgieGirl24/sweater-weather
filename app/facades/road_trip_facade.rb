class RoadTripFacade
  def self.get_trip(road_trip_params)
    origin = road_trip_params[:origin]
    destination = road_trip_params[:destination]
    trip = MapFacade.get_trip(origin, destination) #this gives time and distance
    destination_coordinates = trip[:route][:boundingBox][:lr]
    est_trip_time = trip[:route][:formattedTime]
    real_time = trip[:route][:realTime]
    destination_weather = self.get_forecast_weather(destination) #array of 48 HourlyWeather Objects

    trip_distance = trip[:route][:distance]
    eta_weather_time = Time.now + real_time

    if eta_weather_time.strftime('%M').to_i < 30
      eta_weather_time = eta_weather_time.beginning_of_hour
    else
      eta_weather_time = (eta_weather_time + 1).beginning_of_hour
    end

    weather_time = destination_weather.select do |hourly|
      eta_weather_time.strftime('%H:%M:%S') == hourly.time
    end.first
    # binding.pry
    RoadTrip.new(trip, origin, destination, weather_time)
  end

  def self.get_forecast_weather(destination)
    ForecastFacade.get_forecast_weather(destination)
  end
end
