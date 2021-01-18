class MapFacade
  def self.get_coordinates(location)
    coordinates = MapService.get_coordinates(location)
    Map.new(coordinates)
  end

  def self.get_trip(origin, destination)
    trip_duration = MapService.get_trip_duration(origin, destination)
  end
end
