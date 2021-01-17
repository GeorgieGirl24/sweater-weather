class ImageService
  def self.get_images(location)
    response = conn.get('/search/photos') do |req|
      req.params['query'] = location
    end
    parse_data(response)
  end

  def self.parse_data(response)
    JSON.parse(response.body, symbolize_names: true)
  end
  
  private
  def self.conn
    Faraday.new(ENV['IMAGE_API_HOST']) do |f|
      f.params['client_id'] = ENV['IMAGE_API_KEY']
    end
  end
end
