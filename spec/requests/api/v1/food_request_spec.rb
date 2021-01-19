require 'rails_helper'

RSpec.describe 'Yelp API Final' do
  it 'i can get a restaurant recommendation and weather for destination' do
      yelp_params = {
        start: 'Denver',
        end: 'Pueblo',
        food: 'chinese'
      }

      headers = {
        'CONTENT_TYPE': 'application/json',
        'Authorization': "Bearer #{ENV['YELP_API_KEY']}"
      }

      # response = HTTP.auth("Bearer #{YELP_API_KEY}").get('/api/v1/event', params: yelp_params)
      get '/api/v1/munchies', headers: headers, params: yelp_params
      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(response).to be_a String

      restaurant = JSON.parse(response.body, symbolize_names: true)
      expect(restaurant).to be_a Hash
      binding.pry
  end
end
