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
end
