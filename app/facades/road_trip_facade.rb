class RoadTripFacade
  def self.get_trip(road_trip_params)
    origin = road_trip_params[:origin]
    destination = road_trip_params[:destination]
    trip = MapService.get_trip_duration(origin, destination)
    if trip[:info][:statuscode] != 402
      destination_weather = self.get_forecast_weather(destination)
      weather_time = self.get_eta_weather_time(trip, destination_weather)
      Roadtrip.new(trip, origin, destination, weather_time)
    else
      weather_time = nil
      Roadtrip.new(trip, origin, destination, weather_time)
    end
  end

  def self.get_forecast_weather(destination)
    location = MapService.get_coordinates(destination)
    lat = location[:results][0][:locations][0][:latLng][:lat]
    lng = location[:results][0][:locations][0][:latLng][:lng]
    WeatherService.get_weather(lat, lng)
  end

  def self.get_eta_weather_time(trip, destination_weather)
    eta_weather_time = Time.now + (trip[:route][:realTime])
    self.select_destination_weather(eta_weather_time, destination_weather)
  end

  def self.select_destination_weather(eta_weather_time, destination_weather)
    answer = destination_weather[:hourly].select do |hourly|
      time = (Time.at(hourly[:dt])).strftime('%H:%M:%S')
      self.weather_rounding(eta_weather_time).strftime('%H:%M:%S') == time
    end.first
    HourlyWeather.new(answer)
  end

  def self.weather_rounding(eta_weather_time)
    if eta_weather_time.strftime('%M').to_i < 30
      eta_weather_time.beginning_of_hour
    else
      (eta_weather_time + 1).beginning_of_hour
    end
  end
end
