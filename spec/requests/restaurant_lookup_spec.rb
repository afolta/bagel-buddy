require 'rails_helper'

RSpec.describe "RestaurantsLookupController", type: :request do
  let!(:current_user_latitude) { "39.94709795"}
  let!(:current_user_longitude) { "-75.17313898856435"}
  let!(:user) { User.create(
                         name: "Test Person",
                         email: "testperson@test.com",
                         password: "password",
                         password_confirmation: "password",
                         address: "864 Rose St",
                         city: "West Lafayette",
                         state: "IN",
                         zip: "47906",
                         latitude: current_user_latitude,
                         longitude: current_user_longitude) }
  let!(:jwt) { JWT.encode({ user_id: user.id }, Rails.application.credentials.fetch(:secret_key_base), "HS256") }

  describe "POST /restaurants-lookup successful response" do
    before do
      post '/restaurants-lookup', params: {
        latitude: user.latitude,
        longitude: user.longitude
      },
       headers: { "Authorization" => "Bearer #{jwt}" }
       @response = response
       @restaurants = JSON.parse(@response.body)
    end

    it 'returns an HTTP status of OK' do
      expect(@response).to have_http_status(200)
    end

    it 'returns valid parameters' do
      restaurant_name = @restaurants.map do |restaurant|
        restaurant.fetch('name')
      end

      place_id = @restaurants.map do |restaurant|
        restaurant.fetch('place_id')
      end

      address = @restaurants.map do |restaurant|
        restaurant.fetch('address')
      end

      latitude = @restaurants.map do |restaurant|
        restaurant.fetch('latitude')
      end

      longitude = @restaurants.map do |restaurant|
        restaurant.fetch('longitude')
      end

      rating = @restaurants.map do |restaurant|
        restaurant.fetch('rating')
      end

      user_ratings_total = @restaurants.map do |restaurant|
        restaurant.fetch('user_ratings_total')
      end

      distance = @restaurants.map do |restaurant|
        restaurant.fetch('distance')
      end

      expect(restaurant_name).to_not be_nil
      expect(place_id).to_not be_nil
      expect(address).to_not be_nil
      expect(latitude).to_not be_nil
      expect(longitude).to_not be_nil
      expect(rating).to_not be_nil
      expect(user_ratings_total).to_not be_nil
      expect(distance).to_not be_nil
    end
  end

  describe "POST /restaurants-lookup invalid parameters" do
    before do
      post '/restaurants-lookup', params: {
        latitude: user.latitude,
        longitude: nil
      },
       headers: { "Authorization" => "Bearer #{jwt}" }
       @response = response
       @restaurants = JSON.parse(@response.body)
    end

    it 'returns an HTTP status of Invalid Request' do
      expect(@response).to have_http_status(400)
    end

    it 'returns an empty array of restaurants' do
      expect(@restaurants).to eq([])
    end
  end

  describe "POST /restaurants-lookup no results found" do
    before do
      post '/restaurants-lookup', params: {
        latitude: 39.94709795,
        longitude: 75.1731389
      },
       headers: { "Authorization" => "Bearer #{jwt}" }
       @response = response
       @restaurants = JSON.parse(@response.body)
    end

    it 'returns an HTTP status of Not Found' do
      expect(@response).to have_http_status(404)
    end

    it 'returns an empty array of restaurants' do
      expect(@restaurants).to eq([])
    end
  end
end
