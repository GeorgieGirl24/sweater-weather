class RoadTrip
  attr_reader :start_city,
              :end_city,
              :travel_time,
              :weather

  def initialize(data, origin, destination, weather)
    @start_city = origin
    @end_city = destination
    if !@travel_time.nil?
      @travel_time = 'impossible route'
    else
      @travel_time = data[:route][:formattedTime]
    end
    @weather = {
      temperature: weather.temperature,
      conditions: weather.conditions
    }
binding.pry
  end
end
