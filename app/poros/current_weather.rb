class CurrentWeather
  attr_reader :datetime,
              :sunrise,
              :sunset,
              :temperature,
              :feels_like,
              :humidity,
              :uvi,
              :visibility,
              :conditions,
              :icon
  def initialize(data)
    @datetime = data[:datetime]
    @sunrise = data[:sunrise]
    @sunset = data[:sunset]
    @temperature = fahrenheit(data[:temp])
    @feels_like = fahrenheit(data[:feels_like])
    @humidity = data[:humidity]
    @uvi = data[:uvi]
    @visibility = data[:visibility]
    @conditions = data[:weather][0][:description]
    @icon = data[:weather][0][:icon]
  end

  def fahrenheit(temp)
    binding.pry
    (temp - 273.15) * (9 / 5) + 32
  end
end
