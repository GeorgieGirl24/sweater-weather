class RoadTripFacade
  def self.get_trip(road_trip_params)
    origin = road_trip_params[:origin]
    destination = road_trip_params[:destination]
    trip = MapFacade.get_trip(origin, destination) #this gives time and distance
    destination_weather = self.get_forecast_weather(destination) #array of 48 HourlyWeather Objects
    weather_time = self.get_eta_weather_time(trip, destination_weather)
    Roadtrip.new(trip, origin, destination, weather_time)
  end

  def self.get_forecast_weather(destination)
    ForecastFacade.get_forecast_weather(destination)
  end

  def self.get_eta_weather_time(trip, destination_weather)
    eta_weather_time = Time.now + (trip[:route][:realTime])
    self.select_destination_weather(eta_weather_time, destination_weather)
  end

  def self.weather_rounding(eta_weather_time)
    if eta_weather_time.strftime('%M').to_i < 30
      eta_weather_time = eta_weather_time.beginning_of_hour
    else
      eta_weather_time = (eta_weather_time + 1).beginning_of_hour
    end
  end

  def self.select_destination_weather(eta_weather_time, destination_weather)
    destination_weather.select do |hourly|
      self.weather_rounding(eta_weather_time).strftime('%H:%M:%S') == hourly.time
    end.first
  end
end
