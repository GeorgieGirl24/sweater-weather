require 'rails_helper'

RSpec.describe 'Image API', :vcr do
  describe 'it can get a background image based on the city search' do
    it 'can get an image from Unsplash' do
      location_params = {
        location: 'denver, co'
      }

      get '/api/v1/backgrounds', params: location_params

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(response.content_type).to eq('application/json')

      image = JSON.parse(response.body, symbolize_names: true)
      expect(image).to be_a Hash
      expect(image).to have_key(:results)
      expect(image[:results]).to be_an Array
      expect(image[:results].first).to be_a Hash
      expect(image[:results].first).to have_key(:description)
      expect(image[:results].first).to have_key(:urls)
      expect(image[:results].first[:urls]).to have_key(:regular)
      expect(image[:results].first).to have_key(:links)
      expect(image[:results].first[:links]).to have_key(:html)
      expect(image[:results].first).to have_key(:user)
      expect(image[:results].first[:user]).to have_key(:name)
      expect(image[:results].first[:user]).to have_key(:links)
      expect(image[:results].first[:user][:links]).to have_key(:html)
    end
  end
end
