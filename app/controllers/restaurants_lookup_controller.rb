class RestaurantsLookupController < ApplicationController
  require "uri"
  require "net/http"

  def new
    latitude = params[:latitude]
    longitude = params[:longitude]
    radius = params[:radius] || 8047 ## Defaults to 5 mile radius
    keyword = "bagel"

    url = URI("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{latitude}%2C#{longitude}&radius=#{radius}&type=restaurant&keyword=#{keyword}&key=#{Rails.application.credentials.google_places_api[:api_key]}")

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)

    response = https.request(request)

    render json: response.read_body.as_json
    puts response.read_body
  end
end
