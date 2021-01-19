require 'rails_helper'

RSpec.describe 'MunchiesFacade', :vcr do
  it 'can get Munchies as a return object after calling a MunchiesService' do
    munchies_params = {
      start: 'Denver',
      end: 'Pueblo',
      food: 'chinese'
    }

    headers = {
      'CONTENT_TYPE': 'application/json',
      'Authorization': "Bearer #{ENV['YELP_API_KEY']}"
    }

    munchies = MunchiesFacade.get_restaurant(munchies_params)
    expect(munchies).to be_a Hash
    expect(munchies).to have_key(:businesses)
    expect(munchies[:businesses]).to be_an Array
    expect(munchies[:businesses].first).to be_a Hash
    expect(munchies[:businesses].first).to have_key(:is_closed)
    expect(munchies[:businesses].first[:is_closed]).to be_a Boolean
    expect(munchies[:businesses].first).to have_key(:categories)
    expect(munchies[:businesses].first[:categories]).to be_a Hash
    expect(munchies[:businesses].first[:categories]).to have_key(:alias)
    expect(munchies[:businesses].first[:categories][:alias]).to be_a String
    expect(munchies[:businesses].first).to have_key(:coordinates)
    expect(munchies[:businesses].first[:coordinates]).to be_a Hash
    expect(munchies[:businesses].first[:coordinates]).to have_key(:latitude)
    expect(munchies[:businesses].first[:coordinates][:latitude]).to be_a String
    expect(munchies[:businesses].first[:coordinates]).to have_key(:longitude)
    expect(munchies[:businesses].first[:coordinates][:longitude]).to be_a String
    expect(munchies[:businesses].first).to have_key(:location)
    expect(munchies[:businesses].first[:location]).to be_a Hash
    expect(munchies[:businesses].first[:location]).to have_key(:city)
    expect(munchies[:businesses].first[:location][:city]).to be_a String
    expect(munchies[:businesses].first[:location]).to have_key(:state)
    expect(munchies[:businesses].first[:location][:state]).to be_a String
    expect(munchies[:businesses].first[:location]).to have_key(:address1)
    expect(munchies[:businesses].first[:location][:address1]).to be_a String
    expect(munchies[:businesses].first[:location]).to have_key(:zip_code)
    expect(munchies[:businesses].first[:location][:zip_code]).to be_a String

  end
end