class RatingsController < ApplicationController
    #before_action :set_brewery, only: [:show, :edit, :update, :destroy]

    def create
        Rating.create params.require(:rating).permit(:score, :beer_id)
        redirect_to ratings_path
    end
    def index
        @ratings = Rating.all
    end

    def new
        @rating = Rating.new
        @beers = Beer.all
    end

    def destroy
        rating = Rating.find(params[:id])
        rating.delete
        redirect_to ratings_path
    end
  end