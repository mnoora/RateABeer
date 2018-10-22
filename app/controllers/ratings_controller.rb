class RatingsController < ApplicationController
  # before_action :set_brewery, only: [:show, :edit, :update, :destroy]

  def create
    expire_fragment('ratings_index')
    @rating = Rating.new params.require(:rating).permit(:score, :beer_id)

    if current_user.nil?
      redirect_to signin_path, notice: 'you should be signed in'
    elsif @rating.save
      current_user.ratings << @rating
      redirect_to user_path current_user
    else
      @beers = Beer.all
      render :new
    end
  end

  def index
    # Fragment cache ja eventual consistency
    @ratings = Rating.includes(:user, :beer).all
    @recent_ratings = Rails.cache.fetch('recent_ratings', expires_in: 15.minutes) { Rating.recent }
    @top_beers = Rails.cache.fetch('top_beers', expires_in: 15.minutes) { Beer.top 3 }
    @top_breweries = Rails.cache.fetch('top_breweries', expires_in: 15.minutes) {  Brewery.top 3 }
    @top_styles = Rails.cache.fetch('top_styles', expires_in: 15.minutes) { Style.top 3 }
    @top_users = Rails.cache.fetch('top_users', expires_in: 15.minutes) { User.top 3 }
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def destroy
    expire_fragment('ratings_index')
    rating = Rating.find params[:id]
    rating.delete if current_user == rating.user
    redirect_to user_path(current_user)
  end
end
