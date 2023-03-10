class UsersController < ApplicationController
  require "geocoder"

  def create
    coordinates = Geocoder.search("#{params[:address]} #{params[:city]} #{params[:state]} #{params[:zip]}")

    user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation],
      image_url: params[:image_url],
      address: params[:address],
      city: params[:city],
      state: params[:state],
      zip: params[:zip],
      latitude: coordinates.first.latitude,
      longitude: coordinates.first.longitude,
    )

    if user.save
      render json: { message: "User created successfully" }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :bad_request
    end
  end

  def update
    user = User.find_by(id: params[:id])

    user.address = params[:address]
    user.city = params[:city] || user.city
    user.state = params[:state] || user.state
    user.zip = params[:zip] || user.zip

    coordinates = Geocoder.search("#{user.address} #{user.city} #{user.state} #{user.zip}")

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
end
