require 'rails_helper'

RSpec.describe MapFacade, :vcr do
  it 'can take a location and return the coordinates of the location' do
    location = 'denver, co'
    map = MapFacade.get_coordinates(location)
    expect(map).to be_a Map
    expect(map.id).to be_nil
    expect(map.status_code).to be_an Integer
    expect(map.status_code).to eq(0)
    expect(map.messages).to be_an Array
    expect(map.messages).to be_empty
    expect(map.latitude).to be_an Float
    expect(map.latitude).to eq(39.738453)
    expect(map.longitude).to be_an Float
    expect(map.longitude).to eq(-104.984853)
  end

  it 'can take an origin city and end city and find trip' do
    origin = 'Denver, CO'
    destination = 'Pueblo, CO'
    trip_duration = MapFacade.get_trip(origin, destination)
    expect(trip_duration).to be_a Hash
    expect(trip_duration).to have_key(:boundingBox)
    expect(trip_duration[:boundingBox]).to be_a Hash
    expect(trip_duration[:boundingBox]).to have_key(:lr)
    expect(trip_duration[:boundingBox][:lr]).to be_a Hash
    expect(trip_duration[:boundingBox][:lr]).to have_key(:lng)
    expect(trip_duration[:boundingBox][:lr][:lng]).to be_a Float
    expect(trip_duration[:boundingBox][:lr][:lng]).to eq(-104.605087)
    expect(trip_duration[:boundingBox][:lr]).to have_key(:lat)
    expect(trip_duration[:boundingBox][:lr][:lat]).to be_a Float
    expect(trip_duration[:boundingBox][:lr][:lat]).to eq(38.265427)
    expect(trip_duration[:boundingBox]).to have_key(:ul)
    expect(trip_duration[:boundingBox][:ul]).to be_a Hash
    expect(trip_duration[:boundingBox][:ul]).to have_key(:lng)
    expect(trip_duration[:boundingBox][:ul][:lng]).to be_a Float
    expect(trip_duration[:boundingBox][:ul][:lng]).to eq(-104.98761)
    expect(trip_duration[:boundingBox][:ul]).to have_key(:lat)
    expect(trip_duration[:boundingBox][:ul][:lat]).to be_a Float
    expect(trip_duration[:boundingBox][:ul][:lat]).to eq(39.738453)
    expect(trip_duration).to have_key(:realTime)
    expect(trip_duration[:realTime]).to be_an Integer
    expect(trip_duration[:realTime]).to eq(6643)
    expect(trip_duration).to have_key(:formattedTime)
    expect(trip_duration[:formattedTime]).to be_an String
    expect(trip_duration[:formattedTime]).to eq('01:44:22')
    expect(trip_duration).to have_key(:routeError)
    expect(trip_duration[:routeError]).to be_an Hash
  end
end
