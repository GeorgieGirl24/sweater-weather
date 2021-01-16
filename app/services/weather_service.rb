class WeatherService
  def self.get_weather(map)
    response = conn.get('/data/2.5/onecall') do |req|
      req.params['lat'] = map.latitude
      req.params['lon'] = map.longitude
    end
    parse_data(response)
  end

  def self.parse_data(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  private
  def self.conn
    Faraday.new('http://api.openweathermap.org') do |req|
      req.params['appid'] = ENV['WEATHER_API_KEY']
    end
  end
end
