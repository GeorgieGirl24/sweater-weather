class Image
  attr_reader :description,
              :image_url,
              :location,
              :source,
              :link,
              :artist,
              :artist_link
  def initialize(image_data, location)
    # binding.pry
    @description = image_data[:description]
    @image_url = image_data[:urls][:regular]
    @location = location
    @source = 'unsplash.com'
    @link = image_data[:links][:html]
    @artist = image_data[:user][:name]
    @artist_link = image_data[:user][:links][:html]
  end
end
