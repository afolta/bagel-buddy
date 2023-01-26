class RestaurantsLookupController < ApplicationController
  require "uri"
  require "net/http"
  require "geocoder"

  def new
    # Refactor variables
    @latitude = params[:latitude]
    @longitude = params[:longitude]
    @radius = params[:radius] || 8047 ## Defaults to 5 mile radius
    @keyword = "bagel"

    create_restaurant_lookup_request

    https = Net::HTTP.new(lookup_url.host, lookup_url.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(lookup_url)
    response = https.request(request)
    lookup_response = JSON.parse(response.read_body)

    restaurants = lookup_response["results"].map do |restaurant|
      {
        name: restaurant["name"],
        place_id: restaurant["place_id"],
        address: restaurant["vicinity"],
        latitude: restaurant["geometry"]["location"]["lat"],
        longitude: restaurant["geometry"]["location"]["lng"],
        rating: restaurant["rating"],
        user_ratings_total: restaurant["user_ratings_total"],
        distance: Geocoder::Calculations.distance_between([restaurant["geometry"]["location"]["lat"], restaurant["geometry"]["location"]["lng"]], [current_user.latitude, current_user.longitude]).round(2),
      }
    end

    # Need to find a way to link to the lookup
    # RestaurantLookupResponse.create!(lookup_response: lookup_response[:results])

    sorted = restaurants.sort_by { |elem| elem[:distance] }

    render json: sorted

    puts "\n== LOOKUP RESULTS =="
    puts lookup_response[:results]

    puts "\n== RESTAURANT INFO =="
    puts "Restaurant Names are #{restaurants}"
  end
end

def lookup_url
  @lookup_url = URI("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{@latitude}%2C#{@longitude}&radius=#{@radius}&type=restaurant&keyword=#{@keyword}&key=#{Rails.application.credentials.google_places_api[:api_key]}")
end

private def create_restaurant_lookup_request
  RestaurantLookupRequest.create!(
    lookup_parameters: {
      latitude: @latitude,
      longitude: @longitude,
      radius: @radius,
      keyword: @keyword,
    },
  )
end
