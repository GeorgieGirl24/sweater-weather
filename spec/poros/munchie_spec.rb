require 'rails_helper'

RSpec.describe Munchie, :vcr do
  it 'exsist and has attributes' do
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

    expect(munchies.destination_city).to be_a String
    expect(munchies.destination_city).to eq('Pueblo')
    expect(munchies.travel_time).to be_a String
    expect(munchies.travel_time).to eq('01:44:22')
    expect(munchies.forecast).to be_a Hash
    expect(munchies.forecast).to have_key(:summary)
    expect(munchies.forecast[:summary]).to be_a String
    expect(munchies.forecast[:summary]).to eq('clear sky')
    expect(munchies.forecast).to have_key(:temperature)
    expect(munchies.forecast[:temperature]).to be_a Numeric
    expect(munchies.restaurant).to be_a Hash
    expect(munchies.restaurant).to have_key(:name)
    expect(munchies.restaurant[:name]).to be_a String
    expect(munchies.restaurant[:name]).to eq('Wonderful Bistro')
    expect(munchies.restaurant).to have_key(:address)
    expect(munchies.restaurant[:address]).to be_a String
    address = '4602 N Elizabeth St Ste 120 Pueblo, CO 81008'
    expect(munchies.restaurant[:address]).to eq(address)
  end
end
