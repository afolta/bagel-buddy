class RestaurantsLookupController < ApplicationController
  require "uri"
  require "net/http"
  require "geocoder"

  def perform
    @latitude = params[:latitude]
    @longitude = params[:longitude]
    @radius = params[:radius] || 8047 ## Defaults to 5 mile radius
    @keyword = "bagel"

    # Refactor variables
    required_params = {
      latitude: params[:latitude],
      longitude: params[:longitude],
      keyword: "bagel"
    }

    optional_params = {
      radius: params[:radius] || 8047 ## Defaults to 5 mile radius
    }

    interactor = RestaurantsLookupInteractor.new(required_params, optional_params)

    interactor.execute

    interactor.perform
  end
end
