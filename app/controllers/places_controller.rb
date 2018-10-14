class PlacesController < ApplicationController
  def index
  end

  def show
    @place = BeermappingApi.place_in(session[:city], params[:id])
  end

  def search
    @places = BeermappingApi.places_in(params[:city])
    if @places.empty?
      session[:city] = nil
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      @weather = BeerweatherApi.weather_in(params[:city])
      session[:city] = params[:city]
      render :index
    end
  end
end
