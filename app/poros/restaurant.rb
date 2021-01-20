class Restaurant
  attr_reader :name,
              :address

  def initialize(data)
    @name = data[:businesses].first[:name]
    @address = formatted_address(data)
  end

  def formatted_address(data)
    data[:businesses].first[:location][:display_address].join(' ')
  end
end
