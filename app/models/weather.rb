class Weather < OpenStruct
  def self.rendered_fields
    [:temp_c, :wind_kph]
  end
end
