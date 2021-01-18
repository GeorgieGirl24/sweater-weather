class Image
  attr_reader :image,
              :credit

  def initialize(image_data, location)
    @image = {
      image_url: image_data[:urls][:regular],
      link: image_data[:links][:html],
      location: location,
      source: 'unsplash.com'
    }
    @credit = {
      artist: image_data[:user][:name],
      artist_link: image_data[:user][:links][:html]
    }
  end
end
