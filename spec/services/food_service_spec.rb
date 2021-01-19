require 'rails_helper'

RSpec.describe MunchiesService, :vcr do
  it 'can make a successful faraday call to yelp' do
    destination = 'Pueblo'
    term = 'chinese'

    munchies = MunchiesService.get_restaurant(destination, term)

    expect(munchies).to be_a Hash
    expect(munchies).to have_key(:businesses)
    expect(munchies[:businesses]).to be_an Array
    expect(munchies[:businesses].first).to be_a Hash
    expect(munchies[:businesses].first).to have_key(:is_closed)
    # expect(munchies[:businesses].first[:is_closed]).to be_true.or be_false
    expect(munchies[:businesses].first).to have_key(:categories)
    expect(munchies[:businesses].first[:categories]).to be_an Array
    expect(munchies[:businesses].first[:categories].first).to have_key(:alias)
    expect(munchies[:businesses].first[:categories].first[:alias]).to be_a String
    expect(munchies[:businesses].first).to have_key(:coordinates)
    expect(munchies[:businesses].first[:coordinates]).to be_a Hash
    expect(munchies[:businesses].first[:coordinates]).to have_key(:latitude)
    expect(munchies[:businesses].first[:coordinates][:latitude]).to be_a Float
    expect(munchies[:businesses].first[:coordinates]).to have_key(:longitude)
    expect(munchies[:businesses].first[:coordinates][:longitude]).to be_a Float
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
