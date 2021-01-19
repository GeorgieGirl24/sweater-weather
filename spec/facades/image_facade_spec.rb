require 'rails_helper'

RSpec.describe 'Image Facade', :vcr do
  it 'can call an ImageService with location params' do
    location = 'denver, co'

    image = ImageFacade.get_image(location)
    expect(image).to be_an Image
    expect(image.image).to be_a Hash
    expect(image.image).to have_key(:image_url)
    expect(image.image[:image_url]).to be_a String
    expect(image.image).to have_key(:link)
    expect(image.image[:link]).to be_a String
    expect(image.credit).to have_key(:source)
    expect(image.credit[:source]).to be_a String
    expect(image.image).to_not have_key(:description)
    expect(image.credit).to be_a Hash
    expect(image.credit).to have_key(:artist)
    expect(image.credit[:artist]).to be_a String
    expect(image.credit).to have_key(:artist_link)
    expect(image.credit[:artist_link]).to be_a String
    expected = 'https://images.unsplash.com/photo-1600041161228-519e6dd27bac?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MXwxOTkxNTl8MHwxfHNlYXJjaHwxfHxkZW52ZXIsJTIwY298ZW58MHx8fA&ixlib=rb-1.2.1&q=80&w=1080'
    expect(image.image[:image_url]).to eq(expected)
  end
end
