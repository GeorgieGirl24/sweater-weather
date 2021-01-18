class MapService
  def self.get_coordinates(location)
    response = conn.get('/geocoding/v1/address') do |req|
      req.params['location'] = location
    end
    parse_data(response)
  end

  def self.get_trip_duration(origin, destination)
    response = conn.get('/directions/v2/route') do |req|
      req.params['from'] = origin
      req.params['to'] = destination
      req.params['transportMode'] = 'AUTO' # 'WALKING' 'BICYCLE'
    end
    parse_data(response)
  end

  def self.parse_data(response)
    JSON.parse(response.body, symbolize_names: true)
  end


  private
  def self.conn
    Faraday.new(ENV['MAP_API_HOST']) do |f|
      f.params['key'] = ENV['MAP_API_KEY']
    end
  end
end
