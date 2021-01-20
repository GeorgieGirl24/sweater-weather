require 'rails_helper'

RSpec.describe 'Yelp API Final', :vcr do
  it 'i can get a restaurant recommendation and weather for destination' do
      munchies_params = {
        origin: 'Denver',
        destination: 'Pueblo',
        food: 'chinese'
      }

      headers = {
        'CONTENT_TYPE': 'application/json',
        'Authorization': "Bearer #{ENV['YELP_API_KEY']}"
      }

      get '/api/v1/munchies', headers: headers, params: munchies_params
      expect(response).to be_successful
      expect(response.status).to eq(200)

      restaurant = JSON.parse(response.body, symbolize_names: true)
      expect(restaurant).to be_a Hash
      expect(restaurant[:data][:id]).to be_nil
      expect(restaurant[:data][:type]).to be_a String
      expect(restaurant[:data][:type]).to eq('munchies')
      expect(restaurant[:data][:attributes]).to be_a Hash
      expect(restaurant[:data][:attributes][:destination_city]).to be_a String
      expect(restaurant[:data][:attributes][:travel_time]).to be_a String
      expect(restaurant[:data][:attributes][:forecast]).to be_a Hash
      expect(restaurant[:data][:attributes][:forecast]).to have_key(:summary)
      expect(restaurant[:data][:attributes][:forecast][:summary]).to be_a String
      expect(restaurant[:data][:attributes][:forecast]).to have_key(:temperature)
      expect(restaurant[:data][:attributes][:forecast][:temperature]).to be_a Float
      expect(restaurant[:data][:attributes][:restaurant]).to be_a Hash
      expect(restaurant[:data][:attributes][:restaurant]).to have_key(:name)
      expect(restaurant[:data][:attributes][:restaurant][:name]).to be_a String
      expect(restaurant[:data][:attributes][:restaurant]).to have_key(:address)
      expect(restaurant[:data][:attributes][:restaurant][:address]).to be_a String
  end
end
