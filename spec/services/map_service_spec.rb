require 'rails_helper'

RSpec.describe MapService, :vcr do
  it 'can make a successful faraday call to unsplash' do
    location = 'denver, co'
    map = MapService.get_coordinates(location)

    expect(map).to be_a Hash
    expect(map).to have_key(:results)
    expect(map[:results]).to be_an Array
    expect(map[:results].first).to be_a Hash
    expect(map[:results].first).to have_key(:locations)
    expect(map[:results].first[:locations]).to be_an Array
    expect(map[:results].first[:locations].first).to have_key(:latLng)
    expect(map[:results].first[:locations].first[:latLng]).to be_a Hash
    expect(map[:results].first[:locations].first[:latLng]).to have_key(:lat)
    expect(map[:results].first[:locations].first[:latLng][:lat]).to be_a Float
    lat = 39.738453
    expect(map[:results].first[:locations].first[:latLng][:lat]).to eq(lat)
    expect(map[:results].first[:locations].first[:latLng]).to have_key(:lng)
    expect(map[:results].first[:locations].first[:latLng][:lng]).to be_a Float
    lng = -104.984853
    expect(map[:results].first[:locations].first[:latLng][:lng]).to eq(lng)
  end

  it 'can fail with an error, if there external call is not possible' do
    location = ''
    map = MapService.get_coordinates(location)
    expect(map).to be_a Hash
    expect(map).to have_key(:info)
    expect(map[:info]).to be_a Hash
    expect(map[:info]).to have_key(:statuscode)
    expect(map[:info][:statuscode]).to be_an Integer
    expect(map[:info][:statuscode]).to eq(400)
    expect(map[:info]).to have_key(:messages)
    expect(map[:info][:messages]).to be_an Array
    expected = 'Illegal argument from request: Insufficient info for location'
    expect(map[:info][:messages].first).to eq(expected)
  end
end
