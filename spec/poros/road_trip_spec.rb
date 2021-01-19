require 'rails_helper'

RSpec.describe Roadtrip, :vcr do
  it 'exsists and has attributes' do
    road_trip_params = {
      origin: 'Denver, CO',
      destination: 'Jacksonville, FL'
    }
    roadtrip = RoadTripFacade.get_trip(road_trip_params)

    expect(roadtrip).to be_a Roadtrip
    expect(roadtrip.start_city).to be_a String
    expect(roadtrip.start_city).to eq('Denver, CO')
    expect(roadtrip.end_city).to be_a String
    expect(roadtrip.end_city).to eq('Jacksonville, FL')
    expect(roadtrip.travel_time).to be_a String
    expect(roadtrip.travel_time).to eq('25:26:11')
    expect(roadtrip.weather_at_eta).to be_a Hash
    expect(roadtrip.weather_at_eta).to have_key(:temperature)
    expect(roadtrip.weather_at_eta[:temperature]).to be_a Float
    expect(roadtrip.weather_at_eta[:temperature]).to eq(55.24)
    expect(roadtrip.weather_at_eta).to have_key(:conditions)
    expect(roadtrip.weather_at_eta[:conditions]).to be_a String
    expect(roadtrip.weather_at_eta[:conditions]).to eq('clear sky')
  end

  it 'can plan a trip close by' do
    road_trip_params = {
      origin: 'Denver, CO',
      destination: 'Niwot, CO'
    }
    roadtrip = RoadTripFacade.get_trip(road_trip_params)

    expect(roadtrip).to be_a Roadtrip
    expect(roadtrip.start_city).to be_a String
    expect(roadtrip.start_city).to eq('Denver, CO')
    expect(roadtrip.end_city).to be_a String
    expect(roadtrip.end_city).to eq('Niwot, CO')
    expect(roadtrip.travel_time).to be_a String
    expect(roadtrip.travel_time).to eq('00:42:58')
    expect(roadtrip.weather_at_eta).to be_a Hash
    expect(roadtrip.weather_at_eta).to have_key(:temperature)
    expect(roadtrip.weather_at_eta[:temperature]).to be_a Float
    expect(roadtrip.weather_at_eta[:temperature]).to eq(27.5)
    expect(roadtrip.weather_at_eta).to have_key(:conditions)
    expect(roadtrip.weather_at_eta[:conditions]).to be_a String
    expect(roadtrip.weather_at_eta[:conditions]).to eq('overcast clouds')
  end

  it 'can plan a long, long distance trip' do
    road_trip_params = {
      origin: 'Denver, CO',
      destination: 'Mexico City, Mexico'
    }
    roadtrip = RoadTripFacade.get_trip(road_trip_params)

    expect(roadtrip).to be_a Roadtrip
    expect(roadtrip.start_city).to be_a String
    expect(roadtrip.start_city).to eq('Denver, CO')
    expect(roadtrip.end_city).to be_a String
    expect(roadtrip.end_city).to eq('Mexico City, Mexico')
    expect(roadtrip.travel_time).to be_a String
    expect(roadtrip.travel_time).to eq('31:47:37')
    expect(roadtrip.weather_at_eta).to be_a Hash
    expect(roadtrip.weather_at_eta).to have_key(:temperature)
    expect(roadtrip.weather_at_eta[:temperature]).to be_a Float
    expect(roadtrip.weather_at_eta[:temperature]).to eq(68.31)
    expect(roadtrip.weather_at_eta).to have_key(:conditions)
    expect(roadtrip.weather_at_eta[:conditions]).to be_a String
    expect(roadtrip.weather_at_eta[:conditions]).to eq('broken clouds')
  end

  it 'cannot plan a trip across the ocean' do
    road_trip_params = {
      origin: 'Denver, CO',
      destination: 'Daegu, South Korea'
    }
    roadtrip = RoadTripFacade.get_trip(road_trip_params)

    expect(roadtrip).to be_a Roadtrip
    expect(roadtrip.start_city).to be_a String
    expect(roadtrip.start_city).to eq('Denver, CO')
    expect(roadtrip.end_city).to be_a String
    expect(roadtrip.end_city).to eq('Daegu, South Korea')
    expect(roadtrip.travel_time).to be_a String
    expect(roadtrip.travel_time).to eq('impossible route')
    expect(roadtrip.weather_at_eta).to be_a String
    expect(roadtrip.weather_at_eta).to eq('no data available')
  end

  it 'can plan a long, long, long distance trip' do
    road_trip_params = {
      origin: 'Miami, FL',
      destination: 'Fairbanks, AK'
    }
    roadtrip = RoadTripFacade.get_trip(road_trip_params)

    expect(roadtrip).to be_a Roadtrip
    expect(roadtrip.start_city).to be_a String
    expect(roadtrip.start_city).to eq('Miami, FL')
    expect(roadtrip.end_city).to be_a String
    expect(roadtrip.end_city).to eq('Fairbanks, AK')
    expect(roadtrip.travel_time).to be_a String
    expect(roadtrip.travel_time).to eq('77:32:53')
    expect(roadtrip.weather_at_eta).to be_a Hash
    expect(roadtrip.weather_at_eta).to have_key(:temperature)
    expect(roadtrip.weather_at_eta[:temperature]).to be_a Float
    expect(roadtrip.weather_at_eta[:temperature]).to eq(16.48)
    expect(roadtrip.weather_at_eta).to have_key(:conditions)
    expect(roadtrip.weather_at_eta[:conditions]).to be_a String
    expect(roadtrip.weather_at_eta[:conditions]).to eq('light snow')
  end

  it 'cannot plan a trip across the ocean to Sweden' do
    road_trip_params = {
      origin: 'Denver, CO',
      destination: 'Stockholm, Sweden'
    }
    roadtrip = RoadTripFacade.get_trip(road_trip_params)

    expect(roadtrip).to be_a Roadtrip
    expect(roadtrip.start_city).to be_a String
    expect(roadtrip.start_city).to eq('Denver, CO')
    expect(roadtrip.end_city).to be_a String
    expect(roadtrip.end_city).to eq('Stockholm, Sweden')
    expect(roadtrip.travel_time).to be_a String
    expect(roadtrip.travel_time).to eq('impossible route')
    expect(roadtrip.weather_at_eta).to be_a String
    expect(roadtrip.weather_at_eta).to eq('no data available')
  end
end
