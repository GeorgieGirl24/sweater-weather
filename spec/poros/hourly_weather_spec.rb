require 'rails_helper'

RSpec.describe HourlyWeather, :vcr do
  before :each do
    location = 'denver, co'
    map = MapService.get_coordinates(location)
    lat = map[:results][0][:locations][0][:latLng][:lat]
    lng = map[:results][0][:locations][0][:latLng][:lng]
    forecast = WeatherService.get_weather(lat, lng)
    @many_hours_weather = forecast[:hourly].map do |hour|
      HourlyWeather.new(hour)
    end
  end
  it 'exsists and has attributes' do

    expect(@many_hours_weather).to be_an Array
    hour_weather = @many_hours_weather.first
    expect(hour_weather).to be_a HourlyWeather
    expect(hour_weather.time).to eq('16:00:00')
    expect(hour_weather.time).to_not eq(1610830800) #unformatted
    expect(hour_weather.temperature).to eq(47.77)
    expect(hour_weather.temperature).to_not eq(245.76) #Kelvin
    expect(hour_weather.wind_speed).to eq('10.56 mph')
    expect(hour_weather.wind_speed).to_not eq(5.91) #unformatted
    expect(hour_weather.wind_direction).to eq('from NW')
    expect(hour_weather.wind_direction).to_not eq(79) #unformatted
    expect(hour_weather.conditions).to eq('clear sky')
    expect(hour_weather.icon).to eq('01d')
  end
  describe 'instance methods' do
    it '.find_wind_direction' do
      wind = 79
      hour_weather = @many_hours_weather.first
      expect(hour_weather.find_wind_direction(wind)).to eq('E')
      expect(hour_weather.find_wind_direction(0)).to eq('N')
      expect(hour_weather.find_wind_direction(12)).to eq('NNE')
      expect(hour_weather.find_wind_direction(34)).to eq('NE')
      expect(hour_weather.find_wind_direction(57)).to eq('ENE')
      expect(hour_weather.find_wind_direction(79)).to eq('E')
      expect(hour_weather.find_wind_direction(102)).to eq('ESE')
      expect(hour_weather.find_wind_direction(124)).to eq('SE')
      expect(hour_weather.find_wind_direction(147)).to eq('SSE')
      expect(hour_weather.find_wind_direction(169)).to eq('S')
      expect(hour_weather.find_wind_direction(192)).to eq('SSW')
      expect(hour_weather.find_wind_direction(214)).to eq('SW')
      expect(hour_weather.find_wind_direction(237)).to eq('WSW')
      expect(hour_weather.find_wind_direction(260)).to eq('W')
      expect(hour_weather.find_wind_direction(282)).to eq('WNW')
      expect(hour_weather.find_wind_direction(304)).to eq('NW')
      expect(hour_weather.find_wind_direction(328)).to eq('NNW')
      expect(hour_weather.find_wind_direction(349)).to eq('N')
    end
  end
end
