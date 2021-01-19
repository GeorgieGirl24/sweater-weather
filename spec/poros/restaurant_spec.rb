require 'rails_helper'

RSpec.describe Restaurant, :vcr do
  it 'exsists and has attributes' do
    destination = 'Pueblo'
    term = 'chinese'

    restaurants = MunchiesService.get_restaurants(destination, term)
    restaurant = Restaurant.new(restaurants)
    expect(restaurant).to be_a Restaurant
    expect(restaurant.name).to be_a String
    expect(restaurant.name).to eq('Wonderful Bistro')
    expect(restaurant.name).to_not eq('wonderful-bistro-pueblo')
    expect(restaurant.address).to be_a String
    expect(restaurant.address).to_not be_an Array
    expect(restaurant.address).to eq('4602 N Elizabeth St", "Ste 120", "Pueblo, CO 81008')
    expect(restaurant.address).to_not be_empty
  end
end
