class WeatherService
  def self.get_weather(lat, lon)
    # binding.pry
    response = conn.get('/data/2.5/onecall') do |req|
      req.params['lat'] = lat
      # req.params['lat'] = map[:results][0][:locations][0][:latLng][:lat]
      req.params['lon'] = lon
      # req.params['lon'] = map[:results][0][:locations][0][:latLng][:lng]
      req.params['units'] = 'imperial'
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
