class ForecastFacade
  def self.get_forecast(location)
    map = MapFacade.get_coordinates(location)
    self.get_weather(map)
  end

  def self.get_weather(map)
    weather = WeatherService.get_weather(map)
    # binding.pry
    current_weather = CurrentWeather.new(weather[:current])
    daily_weather = DailyWeather.new(weather[:daily][0..4])
  end
end
