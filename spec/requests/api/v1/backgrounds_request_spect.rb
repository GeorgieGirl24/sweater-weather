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

      image = JSON.parse(response.body, symbolize_names: true)[:data]
      expect(image).to be_a Hash
      expect(image).to have_key(:id)
      expect(image[:id]).to be_nil
      expect(image).to have_key(:type)
      expect(image[:type]).to eq('image')
      expect(image).to have_key(:attributes)
      expect(image[:attributes]).to be_a Hash
      expect(image[:attributes]).to have_key(:credit)
      expect(image[:attributes][:credit]).to be_an Hash
      expect(image[:attributes][:credit]).to have_key(:artist)
      expect(image[:attributes][:credit][:artist]).to be_a String
      expect(image[:attributes][:credit]).to have_key(:artist_link)
      expect(image[:attributes][:credit][:artist_link]).to be_a String
      expect(image[:attributes]).to have_key(:image)
      expect(image[:attributes][:image]).to be_an Hash
      expect(image[:attributes][:image]).to have_key(:image_url)
      expect(image[:attributes][:image][:image_url]).to be_a String
      expect(image[:attributes][:image]).to have_key(:link)
      expect(image[:attributes][:image][:link]).to be_a String
      expect(image[:attributes][:image]).to have_key(:description)
      expect(image[:attributes][:image][:description]).to be_a String
      expect(image[:attributes][:image]).to have_key(:location)
      expect(image[:attributes][:image][:location]).to be_a String
      expect(image[:attributes][:image]).to have_key(:source)
      expect(image[:attributes][:image][:source]).to be_a String
      expect(image[:attributes]).to_not be_an Array
      expect(image[:attributes][:image]).to_not be_an Array
      expect(image[:attributes][:image][:location]).to eq('denver, co')
      expect(image[:attributes][:image][:source]).to eq('unsplash.com')
      expected = 'Walking the streets of downtown Denver on a foggy, freezing cold day.'
      expect(image[:attributes][:image][:description]).to eq(expected)
      expect(image[:attributes][:credit][:artist]).to eq('Owen Lystrup')
    end
  end
end
