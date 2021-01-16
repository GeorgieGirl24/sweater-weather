require 'rails_helper'

RSpec.describe HourlyWeather, :vcr do
  it 'exsists and has attributes' do
    location = 'denver, co'
    map = MapFacade.get_coordinates(location)
    forecast = WeatherService.get_weather(map)
    many_hours_weather = forecast[:hourly].map do |hour|
      HourlyWeather.new(hour)
    end

    expect(many_hours_weather).to be_an Array
    hour_weather = many_hours_weather.first
    expect(hour_weather).to be_a HourlyWeather
    expect(hour_weather.time).to eq('2021-01-16')
    expect(hour_weather.time).to_not eq(1610830800) #unformatted
    expect(hour_weather.temperature).to eq(46.27)
    expect(hour_weather.temperature).to_not eq(245.76) #Kelvin
    expect(hour_weather.wind_speed).to eq('5.91 mph')
    expect(hour_weather.wind_speed).to_not eq(5.91) #unformatted
    expect(hour_weather.wind_direction).to eq('from E')
    expect(hour_weather.wind_direction).to_not eq(79) #unformatted
    expect(hour_weather.conditions).to eq('clear sky')
    expect(hour_weather.icon).to eq('01d')
  end
end
