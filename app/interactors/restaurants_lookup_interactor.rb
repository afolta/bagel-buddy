class RestaurantsLookupInteractor < BaseInteractor
  require "uri"
  require "net/http"
  require "geocoder"

  attr_reader :required_params, :optional_params

  def initialize(params, optional_params)
    super(params)
    @optional_params = optional_params
  end

  def load_params
    @required_params = params.fetch(:required_params)
  end

  def execute
  	# restaurant_lookup = create_restaurant_lookup

    restaurants = restaurants_response
    sorted = restaurants.sort_by { |elem| elem[:distance] }

    render json: sorted

    puts "\n== LOOKUP RESULTS =="
    puts lookup_response[:results]

    puts "\n== RESTAURANT INFO =="
    puts "Restaurant Names are #{restaurants}"
  end

  # def create_restaurant_lookup
  # 	RestaurantLookupRequest.create!(
  # 		lookup_parameters: {
  # 							 latitude:  RestaurantLookupRequest.latitude,
  # 							 longitude: RestaurantLookupRequest.longitude,
  # 							 radius: RestaurantLookupRequest.radius,
  # 							 keyword: RestaurantLookupRequest.keyword
  # 		  }
  # 		)
  # 	end
  # end

  private def restaurants_response
    https = Net::HTTP.new(lookup_url.host, lookup_url.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(lookup_url)
    response = https.request(request)
    lookup_response = JSON.parse(response.read_body)

    lookup_response["results"].map do |restaurant|
      {
        name: restaurant["name"],
        place_id: restaurant["place_id"],
        address: restaurant["vicinity"],
        latitude: restaurant["geometry"]["location"]["lat"],
        longitude: restaurant["geometry"]["location"]["lng"],
        rating: restaurant["rating"],
        user_ratings_total: restaurant["user_ratings_total"],
        distance: Geocoder::Calculations.distance_between(
                                                            [
                                                              restaurant["geometry"]["location"]["lat"],
                                                              restaurant["geometry"]["location"]["lng"]
                                                            ],
                                                            [
                                                              current_user.latitude,
                                                              current_user.longitude
                                                            ]
        ).round(2)
      }
    end
  end

  def http_request
    Net::HTTP.new(lookup_url.host, lookup_url.port)
  end

  def lookup_url
  	@lookup_url = URI("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{params[:latitude]}%2C#{params[:longitude]}&radius=#{optional_params[:radius]}&type=restaurant&keyword=#{params[:keyword]}&key=#{Rails.application.credentials.google_places_api[:api_key]}")
  end
end
