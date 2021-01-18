class ForecastFacade
  def self.get_forecast(location)
    map = MapFacade.get_coordinates(location)
    self.get_weather(map)
  end

  def self.get_weather(map)
    weather = WeatherService.get_weather(map)
    current_weather = CurrentWeather.new(weather[:current])
    daily_weather = (weather[:daily][0..4]).map do |day|
      DailyWeather.new(day)
    end
    hourly_weather = (weather[:hourly][0..7]).map do |hour|
      HourlyWeather.new(hour)
    end
    Forecast.new(current_weather, daily_weather, hourly_weather)
  end

  def self.get_forecast_weather(destination)
    map = MapFacade.get_coordinates(destination)
    self.get_destination_weather(map)
  end

  def self.get_destination_weather(map)
    weather = WeatherService.get_weather(map) #refactor this
    hourly_weather = (weather[:hourly]).map do |hour|
      HourlyWeather.new(hour)
    end
  end
end
