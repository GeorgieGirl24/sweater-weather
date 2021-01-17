require 'rails_helper'

RSpec.describe 'User API', :vcr do
  describe 'user registration' do
    it 'can register a new user' do
      user_params = {
        'email': 'example@email.com',
        'password': 'password',
        'password_confirmation': 'password'
      }

      headers = {
        'CONTENT_TYPE': 'application/json',
        'ACCEPT': 'application/json'
      }

      post '/api/v1/users', headers: headers, params: JSON.generate(user_params)

      expect(response).to be_successful
      expect(response.status).to eq(201)
      expect(response.content_type).to eq('application/json')

      user_response = JSON.parse(response.body, symbolize_names: true)
      expect(user_response).to be_a Hash
      expect(user_response).to have_key(:data)
      expect(user_response[:data]).to be_a Hash
      expect(user_response[:data]).to have_key(:type)
      expect(user_response[:data][:type]).to be_a String
      expect(user_response[:data][:type]).to eq('users')
      expect(user_response[:data]).to have_key(:id)
      expect(user_response[:data][:id]).to be_a String
      expect(user_response[:data]).to have_key(:attributes)
      expect(user_response[:data][:attributes]).to be_a Hash
      expect(user_response[:data][:attributes]).to have_key(:email)
      expect(user_response[:data][:attributes][:email]).to be_a String
      expect(user_response[:data][:attributes]).to have_key(:api_key)
      expect(user_response[:data][:attributes][:api_key]).to be_a String

      expect(user_response[:data][:attributes][:email]).to eq('example@email.com')

      user = User.last
      expect(user).to be_a User
      expect(user.email).to eq(user_params[:email])
      expect(user.api_key).to be_a String
      expect(user.api_key).to eq(user_response[:data][:attributes][:api_key])
    end

    it 'can not add a new User with a missing field' do
      user_params = {
        'email': '',
        'password': 'password',
        'password_confirmation': 'password'
      }

      headers = {
        'CONTENT_TYPE': 'application/json',
        'ACCEPT': 'application/json'
      }

      post '/api/v1/users', headers: headers, params: JSON.generate(user_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(404)
      expect(response.content_type).to eq('text/plain')

      expect(response.body).to be_a String
      expect(response.body).to eq("[:email, [\"can't be blank\"]]")
      # this gets formatted so it looks nicer as an error
    end

    it 'can not add a new User when passwords do not match' do
      user_params = {
        'email': 'example@email.com',
        'password': 'nomatchingpassword',
        'password_confirmation': 'password'
      }

      headers = {
        'CONTENT_TYPE': 'application/json',
        'ACCEPT': 'application/json'
      }

      post '/api/v1/users', headers: headers, params: JSON.generate(user_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(404)
      expect(response.content_type).to eq('text/plain')

      expect(response.body).to be_a String
      expect(response.body).to eq("[:password_confirmation, [\"doesn't match Password\", \"doesn't match Password\"]]")
    end

    it 'cannot add a new User if the email is in use' do
      user_params = {
        'email': 'example@email.com',
        'password': 'password',
        'password_confirmation': 'password'
      }

      headers = {
        'CONTENT_TYPE': 'application/json',
        'ACCEPT': 'application/json'
      }

      post '/api/v1/users', headers: headers, params: JSON.generate(user_params)

      expect(response).to be_successful
      expect(response.status).to eq(201)
      expect(response.content_type).to eq('application/json')

      user_2_params = {
        'email': 'example@email.com',
        'password': 'password',
        'password_confirmation': 'password'
      }

      headers = {
        'CONTENT_TYPE': 'application/json',
        'ACCEPT': 'application/json'
      }

      post '/api/v1/users', headers: headers, params: JSON.generate(user_2_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(404)
      expect(response.content_type).to eq('text/plain')

      expect(response.body).to be_a String
      expect(response.body).to eq("[:email, [\"has already been taken\"]]")
    end
  end
end
