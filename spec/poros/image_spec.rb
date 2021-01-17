require 'rails_helper'

RSpec.describe Image, :vcr do
  it 'exsists and has attributes' do
    location = 'denver, co'
    images = ImageService.get_images(location)
    image = Image.new(images[:results].first, location)
    expect(image).to be_an Image
    expect(image.id).to be_nil
    expect(image.image).to be_a Hash
    expect(image.image).to have_key(:image_url)
    expect(image.image[:image_url]).to be_a String
    expect(image.image).to have_key(:link)
    expect(image.image[:link]).to be_a String
    expect(image.image).to have_key(:location)
    expect(image.image[:location]).to be_a String
    expect(image.image).to have_key(:source)
    expect(image.image[:source]).to be_a String
    expect(image.credit).to be_a Hash
    expect(image.credit).to have_key(:artist)
    expect(image.credit[:artist]).to be_a String
    expect(image.credit).to have_key(:artist_link)
    expect(image.credit[:artist_link]).to be_a String
    expect(image.id).to_not be_an Integer
    expected = 'https://images.unsplash.com/photo-1600041161228-519e6dd27bac?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MXwxOTkxNTl8MHwxfHNlYXJjaHwxfHxkZW52ZXIsJTIwY298ZW58MHx8fA&ixlib=rb-1.2.1&q=80&w=1080'
    expect(image.image[:image_url]).to eq(expected)
    expect(image.image[:link]).to eq('https://unsplash.com/photos/hdzGZRCYMSU')
    expect(image.image[:location]).to eq('denver, co')
    expect(image.image[:source]).to eq('unsplash.com')
    expect(image.credit[:artist]).to eq('Michael Kilcoyne')
    expect(image.credit[:artist_link]).to eq('https://unsplash.com/@mikekilcoyne')
  end
end
