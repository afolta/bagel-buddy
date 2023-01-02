class TripsController < ApplicationController
  def create
    trip = Trip.create(
      user_id: params[:user_id],
      restaurant_id: params[:restaurant_id],
    )
    render json: trip.as_json
  end

  def show
    trip = current_user.trips.find_by(id: params[:id])
    if trip
      render json: trip.as_json
    else
      render json: { message: "This is not your trip! (Or trip doesn't exist)" }
    end
  end
end
