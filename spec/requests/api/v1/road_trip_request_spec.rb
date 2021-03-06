require 'rails_helper'
RSpec.describe 'Roadtrip Api', :vcr do
  describe 'user can create a road trip' do
    it 'successful road trip creation' do
      User.destroy_all
      ActiveRecord::Base.connection.reset_pk_sequence!('users')
      user = User.create(email: 'example@email.com', password: 'password')

      login_params = {
        'email': 'example@email.com',
        'password': 'password'
      }

      road_trip_params = {
        origin: 'Denver, CO',
        destination: 'Pueblo, CO',
        api_key: user.api_key
      }

      headers = {
        'CONTENT_TYPE': 'application/json',
        'ACCEPT': 'application/json'
      }

      post '/api/v1/road_trip', headers: headers, params: JSON.generate(road_trip_params)

      expect(response).to be_successful
      expect(response.status).to be(200)
      expect(response.content_type).to eq('application/json')

      road_trip = JSON.parse(response.body, symbolize_names: true)
      expect(road_trip).to be_a Hash
      expect(road_trip).to have_key(:data)
      expect(road_trip[:data]).to be_a Hash
      expect(road_trip[:data]).to have_key(:type)
      expect(road_trip[:data][:type]).to be_a String
      expect(road_trip[:data][:type]).to eq('roadtrip')
      expect(road_trip[:data]).to have_key(:id)
      expect(road_trip[:data][:id]).to be_nil
      expect(road_trip[:data]).to have_key(:attributes)
      expect(road_trip[:data][:attributes]).to be_a Hash
      expect(road_trip[:data][:attributes]).to have_key(:start_city)
      expect(road_trip[:data][:attributes][:start_city]).to be_a String
      expect(road_trip[:data][:attributes]).to have_key(:end_city)
      expect(road_trip[:data][:attributes][:end_city]).to be_a String
      expect(road_trip[:data][:attributes]).to have_key(:travel_time)
      expect(road_trip[:data][:attributes][:travel_time]).to be_a String
      expect(road_trip[:data][:attributes]).to have_key(:weather_at_eta)
      expect(road_trip[:data][:attributes][:weather_at_eta]).to be_a Hash
      expect(road_trip[:data][:attributes][:weather_at_eta]).to have_key(:temperature)
      expect(road_trip[:data][:attributes][:weather_at_eta][:temperature]).to be_a Float
      expect(road_trip[:data][:attributes][:weather_at_eta]).to have_key(:conditions)
      expect(road_trip[:data][:attributes][:weather_at_eta][:conditions]).to be_a String
    end

    it 'cannot make successful road trip with missing destination_city' do
      User.destroy_all
      ActiveRecord::Base.connection.reset_pk_sequence!('users')
      user = User.create(email: 'example@email.com', password: 'password')

      login_params = {
        'email': 'example@email.com',
        'password': 'password'
      }

      road_trip_params = {
        origin: 'Denver, CO',
        destination: '',
        api_key: user.api_key
      }

      headers = {
        'CONTENT_TYPE': 'application/json',
        'ACCEPT': 'application/json'
      }

      post '/api/v1/road_trip', headers: headers, params: JSON.generate(road_trip_params)

      expect(response).to_not be_successful
      expect(response.status).to be(404)
      expect(response.content_type).to eq('application/json')
      error = "{\"body\":\"Missing/empty fields. Please try again\"}"
      expect(response.body).to eq(error)
    end

    it 'cannot make successful road trip with missing api_key' do
      User.destroy_all
      ActiveRecord::Base.connection.reset_pk_sequence!('users')
      user = User.create(email: 'example@email.com', password: 'password')

      login_params = {
        'email': 'example@email.com',
        'password': 'password'
      }

      road_trip_params = {
        origin: 'Denver, CO',
        destination: 'Pueblo, CO',
        api_key: ''
      }

      headers = {
        'CONTENT_TYPE': 'application/json',
        'ACCEPT': 'application/json'
      }

      post '/api/v1/road_trip', headers: headers, params: JSON.generate(road_trip_params)

      expect(response).to_not be_successful
      expect(response.status).to be(401)
      expect(response.content_type).to eq('application/json')
      error = "{\"body\":\"Missing/incorrect API key. Please try again\"}"
      expect(response.body).to eq(error)
    end

    it 'cannot make successful road trip with non-matching api_key' do
      User.destroy_all
      ActiveRecord::Base.connection.reset_pk_sequence!('users')
      user = User.create(email: 'example@email.com', password: 'password')

      login_params = {
        'email': 'example@email.com',
        'password': 'password'
      }

      expect(user.email).to eq('example@email.com')
      expect(user.password_digest).to be_a String
      expect(user.api_key).to be_a String

      road_trip_params = {
        origin: 'Denver, CO',
        destination: 'Pueblo, CO',
        api_key: 'jgn983hy48thw9begh98h4539h4'
      }

      headers = {
        'CONTENT_TYPE': 'application/json',
        'ACCEPT': 'application/json'
      }

      post '/api/v1/road_trip', headers: headers, params: JSON.generate(road_trip_params)

      expect(user.api_key).to_not eq(road_trip_params[:api_key])
      expect(response).to_not be_successful
      expect(response.status).to be(401)
      expect(response.content_type).to eq('application/json')
      error = "{\"body\":\"Missing/incorrect API key. Please try again\"}"
      expect(response.body).to eq(error)
    end
  end
end
