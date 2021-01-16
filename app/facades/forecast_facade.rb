class ForecastFacade
  def self.get_forecast(location)
    map = MapFacade.get_coordinates(location)
  end
end
