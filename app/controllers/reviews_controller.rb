class ReviewsController < ApplicationController
  require "uri"
  require "net/http"

  def new
    # Refactor variables
    @place_id = params[:place_id]

    RestaurantLookupRequest.create!(lookup_parameters: { place_id: @place_id })

    https = Net::HTTP.new(lookup_url.host, lookup_url.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(lookup_url)
    response = https.request(request)
    lookup_response = JSON.parse(response.read_body)["result"]

    review = lookup_response["reviews"].map do |review|
      {
        restaurant_name: lookup_response["name"],
        place_id: lookup_response["place_id"],
        website: lookup_response["website"],
        icon: lookup_response["icon"],
        phone_number: lookup_response["formatted_phone_number"],
        rating: lookup_response["rating"],
        name: review["author_name"],
        rating: review["rating"],
        text: review["text"],
      }
    end

    # Need to find a way to link to the lookup
    RestaurantLookupResponse.create!(lookup_response: review)

    render json: review

    puts "\n== LOOKUP RESULTS =="
    puts lookup_response[:result]

    puts "\n== REVIEW INFO =="
    puts "Reviews are #{review}"
  end

  def index
    reviews = Review.all
    render json: reviews.as_json
  end

  def lookup_url
    @lookup_url = URI("https://maps.googleapis.com/maps/api/place/details/json?place_id=#{@place_id}&fields=name%2Cplace_id%2Cwebsite%2Crating%2Cformatted_phone_number%2Creview%2Cphoto%2Cicon&key=#{Rails.application.credentials.google_places_api[:api_key]}")
  end
end
