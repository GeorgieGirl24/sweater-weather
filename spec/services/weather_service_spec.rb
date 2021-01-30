require 'rails_helper'

RSpec.describe WeatherService, :vcr do
  it 'can make a successful faraday call to openweathermap' do
    location = 'denver, co'
    map = MapService.get_coordinates(location)
    lat = map[:results][0][:locations][0][:latLng][:lat]
    lng = map[:results][0][:locations][0][:latLng][:lng]

    forecast = WeatherService.get_weather(lat, lng)

    expect(forecast).to be_a Hash
    expect(forecast).to have_key(:lat)
    expect(forecast[:lat]).to eq(lat.round(4))
    expect(forecast).to have_key(:lon)
    expect(forecast[:lon]).to eq(lng.round(4))

    expect(forecast).to have_key(:current)
    expect(forecast[:current]).to be_a Hash
    expect(forecast[:current]).to have_key(:dt)
    expect(forecast[:current][:dt]).to be_an Integer
    expect(Time.at(forecast[:current][:dt])).to be_a Time
    expect(forecast[:current]).to have_key(:sunrise)
    expect(forecast[:current][:sunrise]).to be_an Integer
    expect(Time.at(forecast[:current][:sunrise])).to be_a Time
    expect(forecast[:current]).to have_key(:sunset)
    expect(forecast[:current][:sunset]).to be_an Integer
    expect(Time.at(forecast[:current][:sunset])).to be_a Time
    expect(forecast[:current]).to have_key(:temp)
    expect(forecast[:current][:temp]).to be_an Numeric
    expect(forecast[:current]).to have_key(:feels_like)
    expect(forecast[:current][:feels_like]).to be_an Numeric
    expect(forecast[:current]).to have_key(:humidity)
    expect(forecast[:current][:humidity]).to be_an Numeric
    expect(forecast[:current]).to have_key(:visibility)
    expect(forecast[:current][:visibility]).to be_an Numeric
    expect(forecast[:current]).to have_key(:weather)
    expect(forecast[:current][:weather]).to be_an Array
    expect(forecast[:current][:weather][0]).to have_key(:description)
    expect(forecast[:current][:weather][0][:description]).to be_a String
    expect(forecast[:current][:weather][0]).to have_key(:icon)
    expect(forecast[:current][:weather][0][:icon]).to be_a String
    expect(forecast[:current][:temp]).to eq(28.53)
    expect(forecast[:current][:feels_like]).to eq(18.75)
    expect(forecast[:current][:visibility]).to eq(10000)
    expected = '2021-01-16 17:00:41.000000000 -0700'
    expect(Time.at(forecast[:current][:sunset])).to eq(expected)
    expect(Time.at(forecast[:current][:sunset])).to_not eq(1610841641)
    expect(forecast[:current][:weather][0][:description]).to eq('overcast clouds')
    expect(forecast[:current][:weather][0][:icon]).to eq('04n')

    expect(forecast).to have_key(:daily)
    expect(forecast[:daily]).to be_a Array
    expect(forecast[:daily].length).to eq(8)
    expect(forecast[:daily].first).to have_key(:dt)
    expect(forecast[:daily].first[:dt]).to be_a Integer
    expect(Time.at(forecast[:daily].first[:dt])).to be_a Time
    expect(forecast[:daily].first).to have_key(:sunrise)
    expect(forecast[:daily].first[:sunrise]).to be_a Integer
    expect(Time.at(forecast[:daily].first[:sunrise])).to be_a Time
    expect(forecast[:daily].first).to have_key(:sunset)
    expect(forecast[:daily].first[:sunset]).to be_a Integer
    expect(Time.at(forecast[:daily].first[:sunset])).to be_a Time
    expect(forecast[:daily].first).to have_key(:temp)
    expect(forecast[:daily].first[:temp]).to be_a Hash
    expect(forecast[:daily].first[:temp]).to have_key(:max)
    expect(forecast[:daily].first[:temp][:max]).to be_a Float
    expect(forecast[:daily].first[:temp]).to have_key(:min)
    expect(forecast[:daily].first[:temp][:min]).to be_a Float
    expect(forecast[:daily].first).to have_key(:weather)
    expect(forecast[:daily].first[:weather]).to be_an Array
    expect(forecast[:daily].first[:weather].first).to have_key(:description)
    expect(forecast[:daily].first[:weather].first[:description]).to be_a String
    expect(forecast[:daily].first[:weather].first).to have_key(:icon)
    expect(forecast[:daily].first[:weather].first[:icon]).to be_a String
    description = 'clear sky'
    expect(forecast[:daily].first[:weather].first[:description]).to eq(description)
    expect(forecast[:daily].first[:weather].first[:icon]).to eq('01d')
    expect(forecast[:daily].first[:temp][:max]).to eq(44.33)
    expect(forecast[:daily].first[:temp][:max]).to_not eq(324.53)

    expect(forecast).to have_key(:hourly)
    expect(forecast[:hourly]).to be_an Array
    expect(forecast[:hourly].first).to have_key(:dt)
    expect(forecast[:hourly].first[:dt]).to be_a Integer
    expect(Time.at(forecast[:hourly].first[:dt]).strftime('%Y-%m-%d')).to be_a String
    expect(forecast[:hourly].first).to have_key(:temp)
    expect(forecast[:hourly].first[:temp]).to be_a Float
    expect(forecast[:hourly].first[:temp]).to eq(28.53)
    expect(forecast[:hourly].first).to have_key(:wind_speed)
    expect(forecast[:hourly].first[:wind_speed]).to be_a Float
    expect(forecast[:hourly].first).to have_key(:wind_deg)
    expect(forecast[:hourly].first[:wind_deg]).to be_an Integer
    expect(forecast[:hourly].first[:wind_deg]).to eq(129)
    expect(forecast[:hourly].first).to have_key(:weather)
    expect(forecast[:hourly].first[:weather]).to be_an Array
    expect(forecast[:hourly].first[:weather].first).to have_key(:description)
    expect(forecast[:hourly].first[:weather].first[:description]).to be_a String
    expect(forecast[:hourly].first[:weather].first).to have_key(:icon)
    expect(forecast[:hourly].first[:weather].first[:icon]).to be_a String
  end
end
