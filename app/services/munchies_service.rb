class MunchiesService
  def self.get_restaurant(destination, term)
    response = conn.get('/v3/businesses/search') do |req|
      req.params['location'] = destination
      req.params['term'] = term
      req.params['open_now'] = true
    end
    parse_data(response)
  end

  def self.parse_data(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  private
  def self.conn
    Faraday.new('https://api.yelp.com') do |req|
    req.headers["Authorization"] = "Bearer #{ENV['YELP_API_KEY']}"
    end
  end
end
