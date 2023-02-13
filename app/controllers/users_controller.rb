class UsersController < ApplicationController
  require "geocoder"

  def create
    coordinates_response = Geocoder.search(
      "#{params[:address]}
       #{params[:city]}
       #{params[:state]}
       #{params[:zip]}"
    )

    if coordinates_response === []
      render json: { message: 'Invalid address search' }, status: :bad_request
     else
      create_user(coordinates_response)
    end
  end

  def update
    user = User.find_by(id: params[:id])

    user.address = params[:address]
    user.city = params[:city] || user.city
    user.state = params[:state] || user.state
    user.zip = params[:zip] || user.zip

    coordinates = coordinates(user)

    user.latitude = coordinates.first.latitude
    user.longitude = coordinates.first.longitude

    if user.save
      render json: { message: "User coordinates updated successfully" }
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    user = User.find_by(id: params[:id])
    render json: user
  end

  private def create_user(coordinates_response)
    User.create!(
      name: params[:name],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation],
      image_url: params[:image_url],
      address: params[:address],
      city: params[:city],
      state: params[:state],
      zip: params[:zip],
      latitude: coordinates_response.first.latitude,
      longitude: coordinates_response.first.longitude
    )
    render json: { message: "User created successfully" }, status: :created
  end

  private def coordinates(user)
    Geocoder.search(
      "#{user.address}
       #{user.city}
       #{user.state}
       #{user.zip}"
    )
  end
end
