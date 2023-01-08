class TripsController < ApplicationController
  def create
    trip = Trip.create!(
      user_id: current_user.id,
      restaurant_id: params[:restaurant_id],
      place_id: params[:place_id],
      friendly_date: Time.now.strftime("%m/%d/%Y"),
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

  def destroy
    trip_id = params[:id]
    trip = Trip.find(trip_id)
    trip.destroy
    render json: { message: "Trip successfully destroyed!" }
  end
end
