class Roadtrip
  attr_reader :start_city,
              :end_city,
              :travel_time,
              :weather_at_eta

  def initialize(data, origin, destination, weather)
    @start_city = origin
    @end_city = destination
    if !@travel_time.nil?
      @travel_time = 'impossible route'
    else
      @travel_time = data[:route][:formattedTime]
    end
    @weather_at_eta = {
      temperature: weather.temperature,
      conditions: weather.conditions
    }
  end
end
