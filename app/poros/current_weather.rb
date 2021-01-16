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
    @datetime = Time.at(data[:dt]).strftime('%Y-%m-%d')
    @sunrise = Time.at(data[:sunrise]).strftime('%Y-%m-%d')
    @sunset = Time.at(data[:sunset]).strftime('%Y-%m-%d')
    @temperature = data[:temp]
    @feels_like = data[:feels_like]
    @humidity = data[:humidity]
    @uvi = data[:uvi]
    @visibility = data[:visibility]
    @conditions = data[:weather][0][:description]
    @icon = data[:weather][0][:icon]
  end

  def fahrenheit(temp)
    (temp - 273.15) * (9 / 5) + 32
    # unit = imperical is not being utilized?
  end
end
