require 'rails_helper'

RSpec.describe 'RoadTrip Facade API', :vcr do
  it 'can be given two cities and a Roadtrip Poro is made' do
    User.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('users')
    user = User.create(email: 'example@email.com', password: 'password')

    road_trip_params = {
      origin: 'Denver,CO',
      destination: 'Pueblo,CO',
      api_key: user.api_key
    }
    origin = road_trip_params[:origin]
    destination = road_trip_params[:destination]
    roadtrip = RoadTripFacade.get_trip(road_trip_params)
    expect(roadtrip).to be_a Roadtrip
    # this is getting back a hash from MapService.get_trip_duration
    trip = MapService.get_trip_duration(origin, destination)
    
    expect(trip).to be_a Hash
    expect(trip).to have_key(:route)
    expect(trip[:route]).to have_key(:realTime)

    destination_weather = RoadTripFacade.get_forecast_weather(road_trip_params[:destination])
    expect(destination_weather).to be_an Array
    expect(destination_weather.first).to be_an HourlyWeather

    weather_time = RoadTripFacade.get_eta_weather_time(trip, destination_weather)
    expect(weather_time).to be_a HourlyWeather
    expect(weather_time.conditions).to be_a String
    expect(weather_time.icon).to be_a String
    expect(weather_time.temperature).to be_a Float
    expect(weather_time.time).to be_a String
    expect(weather_time.wind_direction).to be_a String
    expect(weather_time.wind_speed).to be_a String
    eta_weather_time = Time.now + (trip[:route][:realTime])
    select_destination_weather = RoadTripFacade.select_destination_weather(eta_weather_time, destination_weather)
    rounded_weather = RoadTripFacade.weather_rounding(eta_weather_time)

    # expect(rounded_weather).to eq('2021-01-18 23:00:00 -0700')
    # expect(rounded_weather).to_not eq('2021-01-18 23:28:00 -0700')
    # expect(rounded_weather).to_not eq('2021-01-18 24:00:00 -0700')
  end

  it 'cannot find a trip time, if the route is impossible' do
    User.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('users')
    user = User.create(email: 'example@email.com', password: 'password')

    road_trip_params = {
      origin: 'Denver,CO',
      destination: 'Stockholm, Sweden',
      api_key: user.api_key
    }
    trip = MapFacade.get_trip(road_trip_params[:origin], road_trip_params[:destination])
    expect(trip[:info][:statuscode]).to eq(402)
    roadtrip = RoadTripFacade.get_trip(road_trip_params)

    expect(roadtrip).to be_a Roadtrip
    expect(roadtrip.start_city).to be_a String
    expect(roadtrip.start_city).to eq('Denver,CO')
    expect(roadtrip.end_city).to be_a String
    expect(roadtrip.end_city).to eq('Stockholm, Sweden')
    expect(roadtrip.travel_time).to be_a String
    expect(roadtrip.travel_time).to eq('impossible route')
    expect(roadtrip.weather_at_eta).to be_a String
    expect(roadtrip.weather_at_eta).to eq('no data available')
  end
end
