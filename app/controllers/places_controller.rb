class PlacesController < ApplicationController
  def index
  end

  def show
    city = session[:last_city].downcase
    place_id = params[:id]
    bars = Rails.cache.read(city)
    bars.each do |p|
      if p.id == place_id
        @place = p
      end
    end
  end

  def search
    @places = BeermappingApi.places_in(params[:city])
    @weather = BeerweatherApi.places_in(params[:city])
    if @places.empty?
      session[:last_city] = nil
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      session[:last_city] = params[:city]
      render :index
    end
  end
end
