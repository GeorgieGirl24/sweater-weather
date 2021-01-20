require 'rails_helper'

RSpec.describe 'MunchiesFacade', :vcr do
  it 'can get Munchies as a return object after calling a MunchiesService' do
    munchies_params = {
      origin: 'Denver',
      destination: 'Pueblo',
      food: 'chinese'
    }

    restaurants = MunchiesService.get_restaurants(munchies_params[:destination], munchies_params[:term])

    expect(restaurants).to be_a Hash
    expect(restaurants).to have_key(:businesses)
    expect(restaurants[:businesses]).to be_an Array
    expect(restaurants[:businesses].first).to be_a Hash
    expect(restaurants[:businesses].first).to have_key(:is_closed)
    # expect(restaurants[:businesses].first[:is_closed]).to be_a Boolean
    expect(restaurants[:businesses].first).to have_key(:categories)
    expect(restaurants[:businesses].first[:categories]).to be_a Array
    expect(restaurants[:businesses].first[:categories].first).to have_key(:alias)
    expect(restaurants[:businesses].first[:categories].first[:alias]).to be_a String
    expect(restaurants[:businesses].first).to have_key(:coordinates)
    expect(restaurants[:businesses].first[:coordinates]).to be_a Hash
    expect(restaurants[:businesses].first[:coordinates]).to have_key(:latitude)
    expect(restaurants[:businesses].first[:coordinates][:latitude]).to be_a Float
    expect(restaurants[:businesses].first[:coordinates]).to have_key(:longitude)
    expect(restaurants[:businesses].first[:coordinates][:longitude]).to be_a Float
    expect(restaurants[:businesses].first).to have_key(:location)
    expect(restaurants[:businesses].first[:location]).to be_a Hash
    expect(restaurants[:businesses].first[:location]).to have_key(:city)
    expect(restaurants[:businesses].first[:location][:city]).to be_a String
    expect(restaurants[:businesses].first[:location]).to have_key(:state)
    expect(restaurants[:businesses].first[:location][:state]).to be_a String
    expect(restaurants[:businesses].first[:location]).to have_key(:address1)
    expect(restaurants[:businesses].first[:location][:address1]).to be_a String
    expect(restaurants[:businesses].first[:location]).to have_key(:zip_code)
    expect(restaurants[:businesses].first[:location][:zip_code]).to be_a String

  end

  it 'can return a trip from MapApi' do
    munchies_params = {
      origin: 'Denver',
      destination: 'Pueblo',
      food: 'chinese'
    }

    origin = munchies_params[:origin]
    destination = munchies_params[:destination]
    trip = MapFacade.get_trip(origin, destination)

    expect(trip).to be_a Hash
    expect(trip).to have_key(:route)
    expect(trip[:route]).to be_a Hash
    expect(trip[:route]).to have_key(:boundingBox)
    expect(trip[:route][:boundingBox]).to be_a Hash
    expect(trip[:route][:boundingBox]).to have_key(:lr)
    # this is the destination city
    expect(trip[:route][:boundingBox][:lr]).to be_a Hash
    expect(trip[:route][:boundingBox][:lr]).to have_key(:lng)
    expect(trip[:route][:boundingBox][:lr][:lng]).to be_a Float
    expect(trip[:route][:boundingBox][:lr]).to have_key(:lat)
    expect(trip[:route][:boundingBox][:lr][:lat]).to be_a Float
    # this is the origin city
    expect(trip[:route][:boundingBox]).to have_key(:ul)
    expect(trip[:route][:boundingBox][:ul]).to be_a Hash
    expect(trip[:route][:boundingBox][:ul]).to have_key(:lng)
    expect(trip[:route][:boundingBox][:ul][:lng]).to be_a Float
    expect(trip[:route][:boundingBox][:ul]).to have_key(:lat)
    expect(trip[:route][:boundingBox][:ul][:lat]).to be_a Float
    expect(trip[:route]).to have_key(:formattedTime)
    expect(trip[:route][:formattedTime]).to be_a String
  end

  it 'can get Roadtrip PORO with weather and destination' do
    munchies_params = {
      origin: 'Denver',
      destination: 'Pueblo',
      food: 'chinese'
    }

    roadtrip = RoadTripFacade.get_trip(munchies_params)
    expect(roadtrip).to be_a Roadtrip
    expect(roadtrip.end_city).to be_a String
    expect(roadtrip.start_city).to be_a String
    expect(roadtrip.travel_time).to be_a String
    expect(roadtrip.weather_at_eta).to be_a Hash
    expect(roadtrip.weather_at_eta).to have_key(:temperature)
    expect(roadtrip.weather_at_eta[:temperature]).to be_a Float
    expect(roadtrip.weather_at_eta).to have_key(:conditions)
    expect(roadtrip.weather_at_eta[:conditions]).to be_a String

  end

  it 'can make a Munchies PORO' do
    munchies_params = {
      origin: 'Denver',
      destination: 'Pueblo',
      food: 'chinese'
    }

    origin = munchies_params[:origin]
    destination = munchies_params[:destination]
    term = munchies_params[:food]
    restaurants = MunchiesService.get_restaurants(destination, term)
    restaurant = Restaurant.new(restaurants)
    roadtrip = RoadTripFacade.get_trip(munchies_params)

    munchies = Munchie.new(restaurant, roadtrip)
    expect(munchies).to be_a Munchie
    expect(munchies.destination_city).to be_a String
    expect(munchies.travel_time).to be_a String
    expect(munchies.forecast).to be_a Hash
    expect(munchies.forecast).to have_key(:summary)
    expect(munchies.forecast[:summary]).to be_a String
    expect(munchies.forecast).to have_key(:temperature)
    expect(munchies.forecast[:temperature]).to be_a Numeric
    expect(munchies.restaurant).to be_a Hash
    expect(munchies.restaurant).to have_key(:name)
    expect(munchies.restaurant[:name]).to be_a String
    expect(munchies.restaurant).to have_key(:address)
    expect(munchies.restaurant[:address]).to be_a String
  end
end
