class MapService
  def self.get_coordinates(location)
    response = conn.get('/geocoding/v1/address') do |req|
      req.params['location'] = location
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  private
  def self.conn
    Faraday.new('http://www.mapquestapi.com') do |f|
      f.params['key'] = ENV['MAP_API_KEY']
    end
  end
end
