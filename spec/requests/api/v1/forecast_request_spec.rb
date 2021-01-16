require 'rails_helper'

RSpec.describe 'Forecast Controller', :vcr do
  describe 'send forecast by location ' do
    scenario 'can get forecast details' do
      forecast_params = {
        location: 'denver, co'
      }
      get '/api/v1/forecast', params: forecast_params
binding.pry
      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(response.body).to be_an Array
      forecast = JSON.parse(response.body, symbolize_names: true)
      expect(forecast).to be_a Hash
      expect(forecast).to have_key(:data)
      expect(forecast[:data]).to be_a Hash
      expect(forecast[:data]).to have_key(:id)
      expect(forecast[:data][:id]).to be_nil
      expect(forecast[:data][:type]).to eq('forecast')
      expect(forecast[:data].to have_key[:attributes])
      expect(forecast[:data][:attributes]).to be_a Hash

      current_weather = forecast[:data][:attributes][:current_weather]
      expect(current_weather).to be_a Hash
      expect(current_weather).to have_key(:datetime)
      expect(current_weather[:datetime]).to be_a String
      expect(current_weather).to have_key(:sunrise)
      expect(current_weather[:sunrise]).to be_a String
      expect(current_weather).to have_key(:sunset)
      expect(current_weather[:sunset]).to be_a String
      expect(current_weather).to have_key(:temperature) #in Fahrenheit
      expect(current_weather[:temperature]).to be_a Float
      expect(current_weather).to have_key(:feels_like) #in Fahrenheit
      expect(current_weather[:feels_like]).to be_a Float
      expect(current_weather).to have_key(:humidity)
      expect(current_weather[:humidity]).to be_a Float
      expect(current_weather).to have_key(:uvi)
      expect(current_weather[:uvi]).to be_a Float
      expect(current_weather).to have_key(:visibility)
      expect(current_weather[:visibility]).to be_a Float
      expect(current_weather).to have_key(:weather)
      expect(current_weather[:weather]).to have_key(:description)
      expect(current_weather[:weather][:description]).to be_a String
      expect(current_weather[:weather]).to have_key(:icon)
      expect(current_weather[:weather][:icon]).to be_a String
      expect(current_weather).to_not have_key(:clouds)
      expect(current_weather).to_not have_key(:wind_speed)
      expect(current_weather).to_not have_key(:dew_point)
      expect(current_weather).to_not have_key(:dt)
      expect(current_weather[:datetime]).to eq()
      expect(current_weather[:temperature]).to eq()
      expect(current_weather[:feels_like]).to eq()
      expect(current_weather[:icon]).to eq()

      daily_weather = forecast[:data][:attributes][:daily_weather]
      expect(daily_weather).to be_a Array
      expect(daily_weather.count).to eq(5)
      expect(daily_weather.first).to have_key(:dt)
      expect(daily_weather.first[:dt]).to be_a String
      expect(daily_weather.first).to have_key(:sunrise)
      expect(daily_weather.first[:sunrise]).to be_a String
      expect(daily_weather.first).to have_key(:sunset)
      expect(daily_weather.first[:sunset]).to be_a String
      expect(daily_weather.first).to have_key(:temp)
      expect(daily_weather.first[:temp_f]).to be_a Hash #in Fahrenheit
      expect(daily_weather.first[:temp]).to have_key(:max_f)
      expect(daily_weather.first[:temp][:max_f]).to be_a Float #in Fahrenheit
      expect(daily_weather.first[:temp]).to have_key(:min_f)
      expect(daily_weather.first[:temp][:min_f]).to be_a Float #in Fahrenheit
      expect(daily_weather.first[:weather]).to be_a Array
      expect(daily_weather.first[:weather][0]).to have_key(:description)
      expect(daily_weather.first[:weather][0][:description]).to be_a String
      expect(daily_weather.first[:weather][0]).to have_key(:icon)
      expect(daily_weather.first[:weather][0][:icon]).to be_a String
      expect(daily_weather).to_not have_key(:dew_point)
      expect(daily_weather).to_not have_key(:pop)
      expect(daily_weather).to_not have_key(:uvi)
      expect(daily_weather.first[:datetime]).to eq()
      expect(daily_weather.first[:temp]).to eq()
      expect(daily_weather.first[:weather][:description]).to eq()
      expect(daily_weather.first[:icon]).to eq()

      hourly_weather = forecast[:data][:attributes][:hourly_weather]
      expect(hourly_weather.first).to be_a Array
      expect(hourly_weather.first).to eq(8)
      expect(hourly_weather.first).to have_key(:time)
      expect(hourly_weather.first[:time]).to be_a Integer #convert to readable '14:00:00'
      expect(hourly_weather.first).to have_key(:temp)
      expect(hourly_weather.first[:temp]).to be_a String #in Fahrenheit
      expect(hourly_weather.first).to have_key(:wind_speed)
      expect(hourly_weather.first[:wind_speed]).to be_a String #mph
      expect(hourly_weather.first).to have_key(:wind_deg)
      expect(hourly_weather.first[:wind_deg]).to be_a String #convert to numeric value
      expect(hourly_weather.first[:weather]).to be_an Array
      expect(hourly_weather.first[:weather]).to have_key(:description)
      expect(hourly_weather.first[:weather][:description]).to be_a String
      expect(hourly_weather.first[:weather]).to have_key(:icon)
      expect(hourly_weather.first[:weather][:icon]).to be_a String
      expect(daily_weather.first[:wind_speed]).to eq()
      expect(daily_weather.first[:temp]).to eq()
      expect(daily_weather.first[:weather][:description]).to eq()
      expect(daily_weather.first[:icon]).to eq()
    end
  end
end
