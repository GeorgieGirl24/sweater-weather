require 'rails_helper'

RSpec.describe 'Forecast Controller', :vcr do
  describe 'send forecast by location ' do
    scenario 'can get forecast details' do
      forecast_params = {
        location: 'denver, co'
      }
      get '/api/v1/forecast', params: forecast_params
      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(response.body).to be_an String
      forecast = JSON.parse(response.body, symbolize_names: true)
      expect(forecast).to be_a Hash
      expect(forecast).to have_key(:data)
      expect(forecast[:data]).to be_a Hash
      expect(forecast[:data]).to have_key(:id)
      expect(forecast[:data][:id]).to be_nil
      expect(forecast[:data]).to have_key(:type)
      expect(forecast[:data][:type]).to eq('forecast')
      expect(forecast[:data]).to have_key(:attributes)
      expect(forecast[:data][:attributes]).to be_a Hash

      current_weather = forecast[:data][:attributes][:current_weather]
      expect(current_weather).to be_a Hash
      expect(current_weather).to have_key(:datetime)
      expect(current_weather[:datetime]).to be_a String
      expect(current_weather[:datetime]).to eq('2021-01-16T12:43:10.000-07:00')
      expect(current_weather).to have_key(:sunrise)
      expect(current_weather[:sunrise]).to be_a String
      expect(current_weather).to have_key(:sunset)
      expect(current_weather[:sunset]).to be_a String
      expect(current_weather).to have_key(:temperature) #in Fahrenheit
      expect(current_weather[:temperature]).to be_a Float
      expect(current_weather[:temperature]).to eq(45.63)
      expect(current_weather).to have_key(:feels_like) #in Fahrenheit
      expect(current_weather[:feels_like]).to be_a Float
      expect(current_weather[:feels_like]).to eq(38.52)
      expect(current_weather).to have_key(:humidity)
      expect(current_weather[:humidity]).to be_a Numeric
      expect(current_weather).to have_key(:uvi)
      expect(current_weather[:uvi]).to be_a Numeric
      expect(current_weather).to have_key(:visibility)
      expect(current_weather[:visibility]).to be_a Numeric
      expect(current_weather).to have_key(:conditions)
      expect(current_weather[:conditions]).to be_a String
      expect(current_weather).to have_key(:icon)
      expect(current_weather[:icon]).to be_a String
      expect(current_weather[:icon]).to eq('01d')
      expect(current_weather).to_not have_key(:clouds)
      expect(current_weather).to_not have_key(:wind_speed)
      expect(current_weather).to_not have_key(:dew_point)
      expect(current_weather).to_not have_key(:dt)

      daily_weather = forecast[:data][:attributes][:daily_weather]
      expect(daily_weather).to be_a Array
      expect(daily_weather.count).to eq(5)
      expect(daily_weather.first).to have_key(:date)
      expect(daily_weather.first[:date]).to be_a String
      expect(daily_weather.first[:date]).to eq('2021-01-16T12:00:00.000-07:00')
      expect(daily_weather.first).to have_key(:sunrise)
      expect(daily_weather.first[:sunrise]).to be_a String
      expect(daily_weather.first).to have_key(:sunset)
      expect(daily_weather.first[:sunset]).to be_a String
      expect(daily_weather.first).to have_key(:max_temp)
      expect(daily_weather.first[:max_temp]).to be_a Float #in Fahrenheit
      expect(daily_weather.first).to have_key(:min_temp)
      expect(daily_weather.first[:min_temp]).to be_a Float #in Fahrenheit
      expect(daily_weather.first).to have_key(:conditions)
      expect(daily_weather.first[:conditions]).to be_a String
      expect(daily_weather.first[:conditions]).to eq('clear sky')
      expect(daily_weather.first).to have_key(:icon)
      expect(daily_weather.first[:icon]).to be_a String
      expect(daily_weather.first[:icon]).to eq('01d')
      expect(daily_weather.first).to_not have_key(:dew_point)
      expect(daily_weather.first).to_not have_key(:pop)
      expect(daily_weather.first).to_not have_key(:uvi)

      hourly_weather = forecast[:data][:attributes][:hourly_weather]
      expect(hourly_weather).to be_a Array
      expect(hourly_weather.length).to eq(8)
      expect(hourly_weather.first).to have_key(:time)
      expect(hourly_weather.first[:time]).to be_a String #convert to readable '14:00:00'
      expect(hourly_weather.first).to have_key(:temperature)
      expect(hourly_weather.first[:temperature]).to be_a Float #in Fahrenheit
      expect(hourly_weather.first[:temperature]).to eq(45.63)
      expect(hourly_weather.first).to have_key(:wind_speed)
      expect(hourly_weather.first[:wind_speed]).to be_a String #mph
      expect(hourly_weather.first[:wind_speed]).to eq('3.44 mph')
      expect(hourly_weather.first).to have_key(:wind_direction)
      expect(hourly_weather.first[:wind_direction]).to be_a String #convert to numeric value
      expect(hourly_weather.first).to have_key(:conditions)
      expect(hourly_weather.first[:conditions]).to be_a String
      expect(hourly_weather.first[:conditions]).to eq('clear sky')
      expect(hourly_weather.first).to have_key(:icon)
      expect(hourly_weather.first[:icon]).to be_a String
      expect(hourly_weather.first[:icon]).to eq('01d')
      expect(hourly_weather.first).to_not have_key(:dew_point)
      expect(hourly_weather.first).to_not have_key(:visibility)
      expect(hourly_weather.first).to_not have_key(:feels_like)
      expect(hourly_weather.first).to_not have_key(:clouds)
    end
  end
end
