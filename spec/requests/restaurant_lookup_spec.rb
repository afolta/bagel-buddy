require 'rails_helper'

RSpec.describe "RestaurantsLookupController", type: :request do
  describe "POST /restaurants-lookup" do
    let!(:current_user_latitude) { "39.94709795"}
    let!(:current_user_longitude) { "-75.17313898856435"}

    before do
      user = User.create(
                          name: "Test Person",
                          email: "testperson@test.com",
                          password: "password",
                          password_confirmation: "password",
                          address: "864 Rose St",
                          city: "West Lafayette",
                          state: "IN",
                          zip: "47906",
                          latitude: current_user_latitude,
                          longitude: current_user_longitude)

      jwt = JWT.encode({ user_id: user.id }, Rails.application.credentials.fetch(:secret_key_base), "HS256")


      post '/restaurants-lookup', params: {
        latitude: user.latitude,
        longitude: user.longitude
      },
       headers: { "Authorization" => "Bearer #{jwt}" }
       @response = response
       @params = request.params
       @restaurants = JSON.parse(@response.body)
    end

    it 'returns an HTTP status of 200' do
      expect(@response).to have_http_status(200)
    end

    it 'returns a name' do
      restaurant_name = @restaurants.map do |restaurant|
        restaurant.fetch('name')
      end

      expect(restaurant_name).to_not be_nil
    end

    it 'returns a place_id' do
      place_id = @restaurants.map do |restaurant|
        restaurant.fetch('place_id')
      end

      expect(place_id).to_not be_nil
    end

    it 'returns an address' do
      address = @restaurants.map do |restaurant|
        restaurant.fetch('address')
      end

      expect(address).to_not be_nil
    end

    it 'returns a latitude' do
      latitude = @restaurants.map do |restaurant|
        restaurant.fetch('latitude')
      end

      expect(latitude).to_not be_nil
    end

    it 'returns a longitude' do
      longitude = @restaurants.map do |restaurant|
        restaurant.fetch('longitude')
      end

      expect(longitude).to_not be_nil
    end

    it 'returns a rating' do
      rating = @restaurants.map do |restaurant|
        restaurant.fetch('rating')
      end

      expect(rating).to_not be_nil
    end

    it 'returns a user_ratings_total' do
      user_ratings_total = @restaurants.map do |restaurant|
        restaurant.fetch('user_ratings_total')
      end

      expect(user_ratings_total).to_not be_nil
    end

    it 'returns a distance' do
      distance = @restaurants.map do |restaurant|
        restaurant.fetch('distance')
      end

      expect(distance).to_not be_nil
    end
  end
end
