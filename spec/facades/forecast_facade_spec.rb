require 'rails_helper'

RSpec.describe ForecastFacade, :vcr do
  it 'returns a Forcast object when called and give just a location' do
    location = 'denver, co'
    map = MapFacade.get_coordinates(location)
    forecast = ForecastFacade.get_weather(map)
    expect(forecast).to be_a Forecast
    expect(forecast.current_weather).to be_a CurrentWeather
    expect(forecast.current_weather.temperature).to be_a Float
    expect(forecast.current_weather.conditions).to be_a String
    expect(forecast.daily_weather).to be_a Array
    expect(forecast.daily_weather.count).to eq(5)
    expect(forecast.daily_weather.first).to be_a DailyWeather
    expect(forecast.hourly_weather).to be_a Array
    expect(forecast.hourly_weather.count).to eq(8)
    expect(forecast.hourly_weather.first).to be_a HourlyWeather
  end

  it 'can return a HourlyWeather' do
    destination = 'Pueblo, CO'
    map = MapFacade.get_coordinates(destination)
    destination_weather = ForecastFacade.get_destination_weather(map)

    expect(destination_weather).to be_a Array
    expect(destination_weather.first).to be_a HourlyWeather
    expect(destination_weather.first.conditions).to be_a String
    expect(destination_weather.first.icon).to be_a String
    expect(destination_weather.first.temperature).to be_a Float
    expect(destination_weather.first.time).to be_a String
    expect(destination_weather.first.wind_direction).to be_a String
    expect(destination_weather.first.wind_speed).to be_a String
  end

  it 'can call weather for multiple service calls' do
    destination = 'Pueblo, CO'
    map = MapFacade.get_coordinates(destination)
    weather = WeatherService.get_weather(map)

    expect(weather).to be_a Hash
    expect(weather).to have_key(:lat)
    expect(weather[:lat]).to be_a Float
    expect(weather).to have_key(:lon)
    expect(weather[:lon]).to be_a Float
    expect(weather).to have_key(:current)
    expect(weather[:current]).to be_a Hash
    expect(weather).to have_key(:hourly)
    expect(weather[:hourly]).to be_a Array
    expect(weather).to have_key(:daily)
    expect(weather[:daily]).to be_a Array
  end

  it 'can get many HourlyWeather objects' do
    destination = 'Pueblo, CO'
    map = MapFacade.get_coordinates(destination)
    weather = WeatherService.get_weather(map)

    many_hourly_weather = ForecastFacade.get_many_hourly_weather(weather)

    expect(many_hourly_weather).to be_an Array
    expect(many_hourly_weather.count).to eq(48)
    expect(many_hourly_weather.first).to be_an HourlyWeather
    expect(many_hourly_weather.first.conditions).to be_a String
    expect(many_hourly_weather.first.icon).to be_a String
    expect(many_hourly_weather.first.temperature).to be_a Float
    expect(many_hourly_weather.first.wind_direction).to be_a String
    expect(many_hourly_weather.first.wind_speed).to be_a String
  end

  it 'can get eight HourlyWeather objects' do
    destination = 'Pueblo, CO'
    map = MapFacade.get_coordinates(destination)
    weather = WeatherService.get_weather(map)

    hourly_weather = ForecastFacade.hourly_weather(weather)
    expect(hourly_weather).to be_an Array
    expect(hourly_weather.count).to eq(8)
    expect(hourly_weather.first).to be_an HourlyWeather
    expect(hourly_weather.first.conditions).to be_a String
    expect(hourly_weather.first.icon).to be_a String
    expect(hourly_weather.first.temperature).to be_a Float
    expect(hourly_weather.first.wind_direction).to be_a String
    expect(hourly_weather.first.wind_speed).to be_a String
  end

  it 'can get DailyWeather objects' do
    destination = 'Pueblo, CO'
    map = MapFacade.get_coordinates(destination)
    weather = WeatherService.get_weather(map)

    daily_weather = ForecastFacade.daily_weather(weather)

    expect(daily_weather).to be_an Array
    expect(daily_weather.count).to eq(5)
    expect(daily_weather.first).to be_an DailyWeather
    expect(daily_weather.first.conditions).to be_a String
    expect(daily_weather.first.icon).to be_a String
    expect(daily_weather.first.date).to be_a Time
    expect(daily_weather.first.max_temp).to be_a Float
    expect(daily_weather.first.min_temp).to be_a Float
    expect(daily_weather.first.sunrise).to be_a Time
    expect(daily_weather.first.sunset).to be_a Time
  end
end
