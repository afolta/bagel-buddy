class RestaurantsLookupController < ApplicationController
  require "uri"
  require "net/http"

  def new
    # Refactor variables
    latitude = params[:latitude]
    longitude = params[:longitude]
    radius = params[:radius] || 8047 ## Defaults to 5 mile radius
    keyword = "bagel"

    RestaurantLookupRequest.create!(lookup_parameters: { latitude: latitude, longitude: longitude, radius: radius, keyword: keyword })

    url = URI("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{latitude}%2C#{longitude}&radius=#{radius}&type=restaurant&keyword=#{keyword}&key=#{Rails.application.credentials.google_places_api[:api_key]}")

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)
    response = https.request(request)
    lookup_response = JSON.parse(response.read_body)

    restaurants = lookup_response["results"].map do |restaurant|
      {
        name: restaurant["name"],
        latitude: restaurant["geometry"]["location"]["lat"],
        longitude: restaurant["geometry"]["location"]["lng"],
      }
    end

    puts "Restaurant Names are #{restaurants}"

    # Need to find a way to link to the lookup
    RestaurantLookupResponse.create!(lookup_response: lookup_response[:results])

    render json: lookup_response
    # Keep for debugging purposes
    puts lookup_response[:results]
  end
end
