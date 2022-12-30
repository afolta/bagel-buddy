class RestaurantsController < ApplicationController
  def index
    restaurants = Restaurant.all
    render json: restaurants.as_json
  end
end
