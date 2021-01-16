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
    binding.pry
  end
end
