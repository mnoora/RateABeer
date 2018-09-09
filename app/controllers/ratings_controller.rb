class RatingsController < ApplicationController
    #before_action :set_brewery, only: [:show, :edit, :update, :destroy]

    def index
        @ratings = Rating.all
    end
  end