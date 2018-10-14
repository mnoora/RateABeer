class BeerweatherApi
  def self.weather_in(city)
    url = "https://api.apixu.com/v1/current.json?key=#{key}&q=#{city}"
    response = HTTParty.get url
    response.parsed_response['current']
  end

  def self.key
    # raise "BEERWEATHER_APIKEY env variable not defined" if ENV['BEERWEATHER_APIKEY'].nil?

    # ENV['BEERWEATHER_APIKEY']
    "405e107263504156b97121346180710"
  end
end
