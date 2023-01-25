class RestaurantsLookupController < ApplicationController
  require "uri"
  require "net/http"
  require "geocoder"

  def new
    create_restaurant_lookup = restaurant_lookup_request

    https = Net::HTTP.new(lookup_url.host, lookup_url.port)
    https.use_ssl = true
    request

    puts "\n== LOOKUP RESULTS =="
    puts lookup_response[:results]

    puts "\n== RESTAURANT INFO =="
    puts "Restaurant Names are #{restaurants}"
  end

  private def request
    Net::HTTP::Get.new(lookup_url)
  end

  private def lookup_response(request)
    response = https.request(request)
    JSON.parse(response.read_body)
  end

  private def lookup_url
    @latitude = params[:latitude]
    @longitude = params[:longitude]
    @radius = params[:radius] || 8047 ## Defaults to 5 mile radius
    @keyword = "bagel"

    # Can be moved to a config file.
    @lookup_url = URI("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{@latitude}%2C#{@longitude}&radius=#{@radius}&type=restaurant&keyword=#{@keyword}&key=#{Rails.application.credentials.google_places_api[:api_key]}")
  end

  private def restaurant_lookup_request
    RestaurantLookupRequest.create!(
      lookup_parameters: {
        latitude: params[:latitude],
        longitude: params[:longitude],
        radius: params[:radius] || 8047, ## Defaults to 5 mile radius,
        keyword: "bagel",
      },
    )
  end

  private def shaped_response(response)
    lookup_response["results"].map do |restaurant|
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

      sorted = sort_by { |elem| elem[:distance] }
      render json: sorted
    end
  end
end
