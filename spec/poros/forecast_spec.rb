require 'rails_helper'

RSpec.describe Forecast, :vcr do
  it 'exsists and has attributes' do
    location = 'denver, co'
    map = MapFacade.get_coordinates(location)
    forecast = WeatherService.get_weather(map)
    current_weather = CurrentWeather.new(forecast[:current])
    daily_weather = forecast[:daily].map do |daily|
      DailyWeather.new(daily)
    end
    hourly_weather = forecast[:hourly].map do |hour|
      HourlyWeather.new(hour)
    end
    the_forecast = Forecast.new(current_weather,daily_weather,hourly_weather)

    expect(the_forecast).to be_a Forecast
    expect(the_forecast.id).to eq(nil)
    expect(the_forecast.current_weather).to be_a CurrentWeather
    expect(the_forecast.current_weather).to_not be_an Array
    expect(the_forecast.daily_weather).to be_an Array
    expect(the_forecast.daily_weather.first).to be_an DailyWeather
    expect(the_forecast.daily_weather.first.date).to be_a Time
    expect(the_forecast.daily_weather).to_not be_a Hash
    expect(the_forecast.hourly_weather).to be_an Array
    expect(the_forecast.hourly_weather.first).to be_a HourlyWeather
    expect(the_forecast.hourly_weather.first.conditions).to be_a String
    expect(the_forecast.hourly_weather).to_not be_a Hash
  end
end
