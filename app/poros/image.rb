class Image
  attr_reader :id,
              :image,
              :credit

  def initialize(image_data, location)
    @id = nil
    @image = {
      image_url: image_data[:urls][:regular],
      link: image_data[:links][:html],
      description: image_data[:description],
      location: location,
      source: 'unsplash.com'
    }
    @credit = {
      artist: image_data[:user][:name],
      artist_link: image_data[:user][:links][:html]
    }
  end
end
