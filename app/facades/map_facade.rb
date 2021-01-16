class MapFacade
  def self.get_coordinates(location)
    coordinates = MapService.get_coordinates(location)
    Map.new(coordinates)
  end
end
