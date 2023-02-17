class UsersController < ApplicationController
  require "geocoder"

  attr_reader :address, :city, :state, :zip

  def initialize(params = {})
    @address  = params[:address]
    @city = params[:city]
    @state = params[:state]
    @zip = params[:zip]
  end

  def create
    coordinates_response = coordinates(address, city, state, zip)

    if coordinates_response === []
      render json: { message: 'Invalid address search' }, status: :bad_request
     else
      create_user(coordinates_response)
    end
  end

  def update
    user = User.find_by(id: params[:id])

    initialize(params)

    if coordinates(address, city, state, zip) === []
      render json: { message: "Invalid Address" }, status: :unprocessable_entity
    else
      user.update!(
      address: address,
      city: city,
      state: state,
      zip: zip,
      latitude: coordinates(address, city, state, zip).first.latitude,
      longitude: coordinates(address, city, state, zip).first.longitude
    )
      render json: { message: "User address updated successfully" }
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

  private def coordinates(address, city, state, zip)
    Geocoder.search(
      "#{address}
       #{city}
       #{state}
       #{zip}"
    )
  end
end
