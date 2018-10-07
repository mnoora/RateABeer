class BeerweatherApi
  def self.places_in(city)
    city = city.downcase
    Rails.cache.fetch(city, expires_in: 1.week) { get_places_in(city) }
  end

  def self.get_places_in(city)
    url = "http://api.apixu.com/v1/current.json?key=#{key}&q="

    response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"
    weather = response.parsed_response["current"]

    return [] if weather.is_a?(Hash) && weather['temp_c'].nil?

    weather = [weather] if weather.is_a?(Hash)
    weather.map do |w|
      Weather.new(w)
    end
  end

  def self.key
    raise "BEERWEATHER_APIKEY env variable not defined" if ENV['BEERWEATHER_APIKEY'].nil?

    ENV['BEERWEATHER_APIKEY']
  end
end
