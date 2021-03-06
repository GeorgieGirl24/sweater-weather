require 'rails_helper'

RSpec.describe DailyWeather, :vcr do
  it 'has attributes and exists' do
    location = 'denver, co'
    map = MapService.get_coordinates(location)
    lat = map[:results][0][:locations][0][:latLng][:lat]
    lng = map[:results][0][:locations][0][:latLng][:lng]
    forecast = WeatherService.get_weather(lat, lng)
    many_day_weather = forecast[:daily].map do |daily|
      DailyWeather.new(daily)
    end

    expect(many_day_weather.first).to be_a DailyWeather
    expect(many_day_weather.first.date).to eq('2021-01-30')
    expect(many_day_weather.first.date).to_not eq(1_610_071_200)
    sunrise = '2021-01-30 07:09:24.000000000 -0700'
    expect(many_day_weather.first.sunrise).to eq(sunrise)
    expect(many_day_weather.first.sunrise).to_not eq(1_610_056_347)
    sunset = '2021-01-30 17:17:02.000000000 -0700'
    expect(many_day_weather.first.sunset).to eq(sunset)
    expect(many_day_weather.first.sunset).to_not eq(1_610_092_098)
    expect(many_day_weather.first.max_temp).to eq(47.77)
    expect(many_day_weather.first.max_temp).to_not eq(274.74) #Kelvin
    expect(many_day_weather.first.min_temp).to eq(34.36)
    expect(many_day_weather.first.min_temp).to_not eq(234.67) #Kelvin
    expect(many_day_weather.first.conditions).to eq('clear sky')
    expect(many_day_weather.first.icon).to eq('01d')
  end
end
