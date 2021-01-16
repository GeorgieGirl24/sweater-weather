require 'rails_helper'

RSpec.describe Map, :vcr do
  it 'exsists and has attributes' do
    location = 'denver, co'
    coordinates = MapService.get_coordinates(location)
    map = Map.new(coordinates)
    expect(map).to be_a Map
    expect(map.id).to eq(nil)
    expect(map.status_code).to be_an Integer
    expect(map.status_code).to eq(0)
    expect(map.messages).to be_an Array
    expect(map.messages).to be_empty
    expect(map.latitude).to be_a Float
    expect(map.latitude).to eq(39.738453)
    expect(map.latitude).to_not eq(39)
    expect(map.longitude).to be_a Float
    expect(map.longitude).to eq(-104.984853)
    expect(map.longitude).to_not eq(-105)
  end

  it 'returns modified map with no location' do
    location = ''
    coordinates = MapService.get_coordinates(location)
    map = Map.new(coordinates)
    
    expect(map).to be_a Map
    expect(map.id).to eq(nil)
    expect(map.status_code).to be_an Integer
    expect(map.status_code).to eq(400)
    expect(map.messages).to be_an Array
    expect(map.messages.first).to be_a String
    expect(map.messages.first).to eq('Illegal argument from request: Insufficient info for location')
    expect(map.latitude).to be_nil
    expect(map.longitude).to be_nil
  end
end
