class UsersController < ApplicationController
  def create
    user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation],
      image_url: params[:image_url],
      address: params[:address],
      latitude: params[:latitude],
      longitude: params[:longitude],
    )
    if user.save
      render json: { message: "User created successfully" }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :bad_request
    end
  end

  def update
    user = User.find_by(id: params[:id])

    user.address = params[:address] || user.address
    user.city = params[:city] || user.city
    user.state = params[:state] || user.state
    user.zip = params[:zip] || user.zip

    coordiantes = Geocoder.search(full_address)

    user.latitude = coordiantes.first.latitude
    user.longitude = coordiantes.first.longitude

    if user.save
      render json: { message: "User coordinates updated successfully" }
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def full_address
    user.address + user.city + user.state + user.zip
  end
end
