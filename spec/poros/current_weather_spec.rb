require 'rails_helper'

RSpec.describe CurrentWeather, :vcr do
  it 'has attributes and exsists' do
    location = 'denver, co'
    map = MapService.get_coordinates(location)

    lat = map[:results][0][:locations][0][:latLng][:lat]
    lng = map[:results][0][:locations][0][:latLng][:lng]
    forecast = WeatherService.get_weather(lat, lng)
    current_weather = CurrentWeather.new(forecast[:current])

    expect(current_weather).to be_a CurrentWeather
    expect(current_weather.datetime).to be_a Time
    expect(current_weather.datetime).to eq('2021-01-16 13:52:05.000000000 -0700')
    expect(current_weather.datetime).to_not eq(1_610_071_200)
    expect(current_weather.sunrise).to be_a Time
    expect(current_weather.sunrise).to eq('2021-01-16 07:18:33.000000000 -0700')
    expect(current_weather.sunrise).to_not eq(1_610_056_347)
    expect(current_weather.sunset).to be_a Time
    expect(current_weather.sunset).to eq('2021-01-16 17:00:41.000000000 -0700')
    expect(current_weather.sunset).to_not eq(1_610_092_098)
    expect(current_weather.temperature).to be_a Float
    expect(current_weather.temperature).to eq(47.88)
    expect(current_weather.temperature).to_not eq(274.74)
    expect(current_weather.feels_like).to be_a Float
    expect(current_weather.feels_like).to eq(41.54)
    expect(current_weather.feels_like).to_not eq(264.82)
    expect(current_weather.humidity).to be_a Numeric
    expect(current_weather.humidity).to eq(38)
    expect(current_weather.uvi).to be_a Numeric
    expect(current_weather.uvi).to eq(1.17)
    expect(current_weather.visibility).to be_a Numeric
    expect(current_weather.visibility).to eq(10000)
    expect(current_weather.conditions).to be_a String
    expect(current_weather.conditions).to eq('clear sky')
    expect(current_weather.icon).to be_a String
    expect(current_weather.icon).to eq('01d')
  end
end
