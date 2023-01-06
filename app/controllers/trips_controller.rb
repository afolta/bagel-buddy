class TripsController < ApplicationController
  def create
    trip = Trip.create(
      user_id: params[:user_id],
      restaurant_id: params[:restaurant_id],
      notes: params[:notes],
    )
    render json: trip.as_json
  end

  def index
    trips = Trip.all
    render json: trips.as_json
  end

  def trips_by_place_id
    trip = Trip.where(place_id: params[:id])
    if trip
      render json: trip.as_json
    else
      render json: { notes: "There are no notes for this place." }
    end
  end
end
